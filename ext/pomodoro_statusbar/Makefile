clean:
	rm -rf a.out

install: a.out
	cp a.out pomodoro_statusbar

a.out: main.m
	clang -framework Cocoa -o a.out main.m
