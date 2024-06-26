build:
	javac -classpath "huffman_toolkit.jar:." *.java

run:
	ls sample_*.txt | xargs -I {} java -classpath "huffman_toolkit.jar:." -ea Test {}

clean:
	rm *.class
