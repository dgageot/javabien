---
title: "PdfBox to unit test pdf files"
date: 2009-05-01T12:00:00+01:00
tags: ["fest assert","pdf","pdfbox","tests"]
---

If you generate a pdf file in your application, there is an easy way to unit test its content using <a href="http://incubator.apache.org/pdfbox/">pdfBox</a>.

I tend to prefer <a href="http://www.lowagie.com/iText/">iText</a> to generate pdfs but pdfBox is easy enough to use to verify documents:

First, you need to import <a href="http://incubator.apache.org/pdfbox/">pdfBox</a> in your pom.xml:

```xml
<dependency>
   <groupid>org.pdfbox</groupid>
   <artifactid>com.springsource.org.pdfbox</artifactid>
   <version>0.7.3</version>
   <scope>test</scope>
</dependency>
```

Here is a method to extract the whole text from a pdf:

```java
private static String extractPdfText(byte[] pdfData) throws IOException {
   PDDocument pdfDocument = PDDocument.load(new ByteArrayInputStream(pdfData));
   try {
      return new PDFTextStripper().getText(pdfDocument);
   } finally {
      pdfDocument.close();
   }
}
```

This is useful to verify that the pdf you've generated contains a given piece of text (I use <a href="http://fest.easytesting.org/assert/wiki/pmwiki.php">Fest Assert</a> for assertions):

```java
assertThat(extractPdfText(pdfData)).contains("a text").contains("another text");
```

Here is another piece of code (more obscure) to verify that a pdf file is signed:

```java
private static boolean isSigned(byte[] pdfData) throws IOException {
  PDDocument pdfDocument = PDDocument.load(new ByteArrayInputStream(pdfData));
  try {
    COSDictionary trailer = pdfDocument.getDocument().getTrailer();
    COSDictionary root = (COSDictionary) trailer.getDictionaryObject(COSName.ROOT);
    COSDictionary acroForm = (COSDictionary) root.getDictionaryObject(COSName.getPDFName("AcroForm"));
    if (null != acroForm) {
      COSArray fields = (COSArray) acroForm.getDictionaryObject(COSName.getPDFName("Fields"));
      for (int i = 0; i < fields.size(); i++) {
        COSDictionary field = (COSDictionary) fields.getObject(i);
        String type = field.getNameAsString("FT");
        if ("Sig".equals(type)) {
          return true;
        }
      }
    }
  } finally {
    pdfDocument.close();
  }

  return false;
}
```
