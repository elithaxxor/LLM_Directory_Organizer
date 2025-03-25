"""
This script iterates through a folder of penetration testing tools.
It uses keywords from each file’s name to decide a category,
creates a folder for that category (if needed), and moves the file into it.
"""


## Step 1: Pre Build

# LLM_basics.py

This script, `LLM_basics.py`, contains various Natural Language Processing (NLP) tasks using the Natural Language Toolkit (NLTK) in Python. Below is a breakdown of the functionalities implemented in this file.

## Functionalities

### 1. Tokenization
Tokenization is the process of breaking down a sentence into individual words or tokens. In this script, we tokenize a sample sentence as follows:
```python
sentence = """At eight o'clock on Thursday morning
... Arthur didn't feel very good."""
tokens = nltk.word_tokenize(sentence)
print(tokens)
# Output: ['At', 'eight', "o'clock", 'on', 'Thursday', 'morning', 'Arthur', 'did', "n't", 'feel', 'very', 'good', '.']
```

### 2. Part-of-Speech Tagging
Part-of-speech (POS) tagging assigns parts of speech to each token such as nouns, verbs, adjectives, etc.
```python
tagged = nltk.pos_tag(tokens)
print(tagged[0:6])
# Output: [('At', 'IN'), ('eight', 'CD'), ("o'clock", 'JJ'), ('on', 'IN'), ('Thursday', 'NNP'), ('morning', 'NN')]
```

### 3. Named Entity Recognition
Named Entity Recognition (NER) identifies named entities like persons, organizations, locations, etc., in the text.
```python
entities = nltk.chunk.ne_chunk(tagged)
print(entities)
```

### 4. Counting POS Tags
This section counts the number of each POS tag in a given text.
```python
text = "Guru99 is one of the best sites to learn WEB, SAP, Ethical Hacking and much more online."
lower_case = text.lower()
tokens = nltk.word_tokenize(lower_case)
tags = nltk.pos_tag(tokens)
counts = Counter(tag for word, tag in tags)
print(counts)
```

### 5. Parsing and Visualizing Syntax Trees
This part of the script parses sentences and visualizes their syntax trees using NLTK's Treebank parser.
```python
t = treebank.parsed_sents('wsj_0001.mrg')[0]
t.draw()
```

### 6. Frequency Distribution Plot
The script also includes functionality to plot the frequency distribution of words in a given text.
```python
a = "Gase visit the site guru99.com and much more."
words = nltk.tokenize.word_tokenize(a)
fd = nltk.FreqDist(words)
fd.plot()
```

## Dependencies
To run this script, you need to install the following Python libraries:
- `nltk`
- `matplotlib` (for plotting frequency distributions)

You can install these libraries using pip:
```sh
pip install nltk matplotlib
```

## How to Run
1. Ensure you have the required dependencies installed.
2. Run the script using Python:
```sh
python LLM_basics.py
```

## Notes
- Make sure you have downloaded the necessary NLTK datasets and corpora. You can do this by running:
```python
import nltk
nltk.download('all')
```

## Additional Information
This script is part of the `LLM_Directory_Organizer` repository, which includes various implementations leveraging traditional keyword matching algorithms and several choices of Language Models (LLMs). For more information, visit the [repository](https://github.com/elithaxxor/LLM_Directory_Organizer).

For further reading or similar scripts, you can check out the [NLTK_basics.py](https://github.com/elithaxxor/machine_learning/blob/main_pi/NLTK_basics.py) file in the `machine_learning` repository.
