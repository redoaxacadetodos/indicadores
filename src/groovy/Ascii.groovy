import java.text.Normalizer

class Ascii {

    public static String quitarAcentos(String s) {
        String temp = Normalizer.normalize(s, Normalizer.Form.NFD);
        return temp.replaceAll("[^\\p{ASCII}]", "");
    }
}


