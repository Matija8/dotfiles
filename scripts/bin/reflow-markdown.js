#!/usr/bin/env node

const fs = require('fs');

function reflowMarkdown(markdownContent, lineWidth) {
  const lines = markdownContent.split('\n');
  const reflowedLines = [];

  for (const line of lines) {
    let currentLine = '';
    let wordsInLine = line.trim().split(' ');

    for (const word of wordsInLine) {
      if (currentLine.length + word.length <= lineWidth) {
        currentLine += word + ' ';
      } else {
        reflowedLines.push(currentLine.trim());
        currentLine = word + ' ';
      }
    }

    reflowedLines.push(currentLine.trim());
  }

  return reflowedLines.join('\n');
}

// Read the Markdown file
const filePath = process.argv[2];
console.log(`$*$ log `, { filePath }); //T*DO
const markdownContent = fs.readFileSync(filePath, 'utf8');

// Reflow Markdown text to have a line width of 80 characters
const lineWidth = 80;
const reflowedContent = reflowMarkdown(markdownContent, lineWidth);

// Write the reflowed Markdown
const outputFilePath = filePath;
fs.writeFileSync(outputFilePath, reflowedContent, 'utf8');

console.log(`Reflowed Markdown successfully written for file:\n${filePath}`);
