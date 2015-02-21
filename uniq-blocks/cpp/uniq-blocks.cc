#include <unordered_map>
#include <string>
#include <fstream>
#include <iostream>
#include <array>

void dedupleFile(std::ifstream &f)
{
    std::unordered_map<std::string, int> M;
    std::array<char, 512> buffer = { 0 };
    char *ptr = &buffer[0];

    while (f.read(ptr, 512)) {
        std::string key(ptr);
        if (M.count(key) > 0) {
            M[key] += 1;
        } else {
            M[key] = 1;
        }
    }
}

int main(int argc, char *argv[])
{
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <filename>" << std::endl;
        return 1;
    }

    std::ifstream is(argv[1], std::ifstream::binary);
    if (is) {
        dedupleFile(is);
    } else {
        std::cerr << "reading failed" << std::endl;
    }

    return 0;
}
