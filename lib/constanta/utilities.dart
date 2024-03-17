const String fileImage = "image";
const String fileVideo = "video";
const String fileTypeFile = "file";

class Utilities {
  static String getFileType(String _extension) {
    List<String> imageExt = ['png', 'jpg', 'jpeg'];
    List<String> videoExt = ['mov', 'mp4', 'mpeg', 'mkv', 'webm', 'flv', 'wmv'];
    if (imageExt.contains(_extension.toLowerCase())) {
      return fileImage;
    } else if (videoExt.contains(_extension.toLowerCase())) {
      return fileVideo;
    } else {
      return fileTypeFile;
    }
  }

  static String dateMonthYear(DateTime dateTime) {
    try {
      var months = [
        "Jan",
        "Feb",
        "Mar",
        "Apr",
        "May",
        "Jun",
        "Jul",
        "Aug",
        "Sep",
        "Oct",
        "Nov",
        "Dec",
      ];

      var monthName = months[dateTime.month - 1];
      return monthName + ' ' + dateTime.year.toString();
    } catch (e) {
      return '';
    }
  }
}
