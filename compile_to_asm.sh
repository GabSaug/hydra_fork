# $1: name of the c file to compile to assembly
# $2 output path
opt="$(echo $3 | sed -e "s/-O0/$(cat /etc/gcc.opt)/g") -Wno-error -finline-limit=2"
if ! cc -masm=intel -I. -g -fcommon -Wno-deprecated-declarations -pie -fPIE -fstack-protector-all --param ssp-buffer-size=4 -D_FORTIFY_SOURCE=2 -Wl,-z,now -Wl,-z,relro -Wl,--allow-multiple-definition $opt -D_GNU_SOURCE -S "$1" -DLIBOPENSSL -DLIBNCURSES -DHAVE_PCRE -DHAVE_ZLIB -DHAVE_MATH_H  -I/usr/include -I/usr/include -o "$2"; then
	echo "error compile to asm"
	exit 1
fi
