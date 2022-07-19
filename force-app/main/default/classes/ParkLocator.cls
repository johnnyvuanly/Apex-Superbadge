public class ParkLocator {
    public static List <String> country(String country) {
        // Instantiate park service class 
        ParkService.ParksImplPort prkSvc = new ParkService.ParksImplPort();
        return prkSvc.byCountry(country);
    }
}
