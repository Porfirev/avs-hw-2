#include <stdio.h>
#include <stdbool.h>
void read_str(char* str) {
    int i = 0;
    int ch;
    do {
        ch = fgetc(stdin);
        str[i++] = ch;
    } while(ch != -1);
    str[i-1] = '\0';
}

bool is_letter(char c) {
	return ('a' <= c && c <= 'z') || ('A' <= c && c <= 'Z');
} 

// Полуинтервал
void make_reverse_str(char* str, int left, int right) {
	for (int i = left; i < (left + right) / 2; ++i) {
		char tmp = str[i];
		str[i] = str[right + left - i - 1];
		str[right + left - i - 1] = tmp;
	}
}

void make_reverse_words(char* str) {
	int len = 0;
	for (; str[len] != '\0'; ++len) { }
	make_reverse_str(str, 0, len);
	int start_word = 0;
	int end_word = 0;
	bool is_word = false;
	for (int i = 0; i < len; ++i) {
		if (is_letter(str[i])) {
			if (!is_word) {
				start_word = i;
				end_word = i;
				is_word = true;
			}
			end_word++;
		} else if (is_word) {
			make_reverse_str(str, start_word, end_word);
			is_word = false;
		}
	}
	if (is_word) {
		make_reverse_str(str, start_word, end_word);
	}
}

int main() {
	int cap = 1000;
	char str[cap];
	printf("Введи строку (закончив нажмите Ctrl + D):\n");
	read_str(str);
	printf("\nВот ваша строка:\n");
    printf("%s\n", str);
    make_reverse_words(str);
    printf("Вот развёрнутая строка:\n");
    printf("%s\n", str);
    return 0;
}
