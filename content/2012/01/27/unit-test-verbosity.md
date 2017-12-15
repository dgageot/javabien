---
title: "Unit test verbosity"
date: 2012-01-27T12:00:00+01:00
tags: ["tests"]
---

Here is a sample test method I found in one of my customer's codebase. What do you think? What's the minimum number of lines really needed to write the exact same test?

The sad thing is that, in the codebase, there are hundreds of tests like this one. All copy/pasted from the same verbose template.

```java
/**
 *
 */
@Test
public void testGetCustomerOK() {

  LOGGER.info("======= testGetCustomerOK starting...");

  try {
    CustomerDTO targetDTO = this.serviceImpl.getCustomer("ABC99");

    // Vérifier.
    Assert.assertNotNull("Extra non trouvé.", targetDTO);
    Assert.assertEquals("Les accountId doivent être identiques.",
	    "ABC99", targetDTO.getAccountId());

  } catch (CustomerBusinessException exception) {
    LOGGER.error("CustomerBusinessException : {}",
	    exception.getCause());
    Assert.fail(exception.getMessage());
  } catch (UnavailableResourceException exception) {
    LOGGER.error("UnavailableResourceException : {}",
	    exception.getMessage());
    Assert.fail(exception.getMessage());
  } catch (UnexpectedException exception) {
    LOGGER.error("UnexpectedException : {}" +
	    exception.getMessage());
    Assert.fail(exception.getMessage());
  } catch (Exception exception) {
    LOGGER.error("CRASH : " + exception.getMessage());
    Assert.fail(exception.getMessage());
  }

  LOGGER.info("======= testGetCustomerOK done.");
}
```
