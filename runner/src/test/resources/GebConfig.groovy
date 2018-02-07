import org.openqa.selenium.chrome.ChromeDriver
import org.openqa.selenium.chrome.ChromeOptions

waiting {
    timeout = 2
}

driver = {
    ChromeOptions o = new ChromeOptions()
    // We want to be headless, and Chrome in Docker requires 'no-sandbox'
    o.addArguments('headless', 'no-sandbox')
    new ChromeDriver(o)
}
