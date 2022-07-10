trigger CalloutExample on Account (before insert, before update) {
    CalloutClass.makeCallout();
}