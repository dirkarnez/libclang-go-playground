package main

/*
#cgo LDFLAGS: -L${SRCDIR}/lib/LLVM-21.1.2-win64/lib -lclang
#cgo CFLAGS: -I${SRCDIR}/lib/LLVM-21.1.2-win64/include -w

#include <clang-c/Index.h>
#include <stdlib.h> // For free

// Wrapper function to parse a C++ file using libclang

	CXTranslationUnit parse_cpp_file_c(const char* filepath) {
	    CXIndex index = clang_createIndex(0, 0);
	    CXTranslationUnit tu = clang_parseTranslationUnit(
	        index,
	        filepath,
	        NULL, 0, // command line arguments
	        NULL, 0, // unsaved files
	        CXTranslationUnit_None
	    );
	    // clang_disposeIndex(index); // Don't dispose until tu is no longer needed
	    return tu;
	}

// Example to get a cursor from a translation unit

	CXCursor get_translation_unit_cursor(CXTranslationUnit tu) {
	    return clang_getTranslationUnitCursor(tu);
	}

// Function to dispose the translation unit

	void dispose_translation_unit_c(CXTranslationUnit tu) {
	    clang_disposeTranslationUnit(tu);
	}
*/
import "C"
import (
	"fmt"
	"os"
	"path/filepath"
	"unsafe"
)

func GetSampleCppFile() (string, error) {
	path, err := os.Executable()
	if err != nil {
		return "", err
	}

	indexHPath := filepath.Join(filepath.Dir(path), "lib", "LLVM-21.1.2-win64", "include", "clang-c", "Index.h")
	_, err = os.Stat(indexHPath)
	if err != nil {
		if os.IsNotExist(err) {
			return "", fmt.Errorf(".\\lib\\LLVM-21.1.2-win64\\include\\clang-c\\Index.h cannot be found")
		} else {
			return "", fmt.Errorf(".\\lib\\LLVM-21.1.2-win64\\include\\clang-c\\Index.h cannot be accessed")
		}
	}

	return indexHPath, nil
}

func main() {
	sampleCppFile, _ := GetSampleCppFile()
	cFilepath := C.CString(sampleCppFile)
	defer C.free(unsafe.Pointer(cFilepath))
	tu := C.parse_cpp_file_c(cFilepath)
	if tu == nil {
		fmt.Println("Failed to parse C++ file.")
		return
	}
	defer C.dispose_translation_unit_c(tu)
	// Now you can work with the translation unit and its cursor to extract information
	cursor := C.get_translation_unit_cursor(tu)
	fmt.Printf("Parsed C++ file: %s (Cursor kind: %d)\n", sampleCppFile, cursor.kind)
}
