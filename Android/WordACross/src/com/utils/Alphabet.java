package com.utils;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.HashMap;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/31/11
 * Time: 6:50 PM
 */
public class Alphabet {

     public static HashMap<String, Float> letterFrequency;
     public static ArrayList<String> chars;

    static
    {
         letterFrequency = new HashMap<String, Float>();
        letterFrequency.put("a", 8.167f);
        letterFrequency.put("b", 1.492f);
        letterFrequency.put("c", 2.782f);
        letterFrequency.put("d", 12.702f);
        letterFrequency.put("e", 8.167f);
        letterFrequency.put("f", 2.228f);
        letterFrequency.put("g", 2.015f);
        letterFrequency.put("h", 6.094f);
        letterFrequency.put("i", 6.966f);
        letterFrequency.put("j", 0.153f);
        letterFrequency.put("k", 0.772f);
        letterFrequency.put("l", 4.025f);
        letterFrequency.put("m", 2.406f);
        letterFrequency.put("n", 6.749f);
        letterFrequency.put("o", 7.507f);
        letterFrequency.put("p", 0.095f);
        letterFrequency.put("q", 0.095f);
        letterFrequency.put("r", 5.987f);
        letterFrequency.put("s", 6.327f);
        letterFrequency.put("t", 9.056f);
        letterFrequency.put("u", 2.758f);
        letterFrequency.put("v", 0.978f);
        letterFrequency.put("w", 2.360f);
        letterFrequency.put("x", 0.150f);
        letterFrequency.put("y", 1.974f);
        letterFrequency.put("z", 0.174f);
    }
    static
    {
        chars=new ArrayList<String>();
        chars.add("a");
        chars.add("b");
        chars.add("c");
        chars.add("d");
        chars.add("e");
        chars.add("f");
        chars.add("g");
        chars.add("h");
        chars.add("i");
        chars.add("j");
        chars.add("k");
        chars.add("l");
        chars.add("m");
        chars.add("n");
        chars.add("o");
        chars.add("p");
        chars.add("q");
        chars.add("r");
        chars.add("s");
        chars.add("t");
        chars.add("u");
        chars.add("v");
        chars.add("w");
        chars.add("x");
        chars.add("y");
        chars.add("z");
    }

    //  calculates how much a word is worth
    public static int calculateWordValue(String word)
    {
        int score = 0;

        for (int i = 0; i < word.length(); i++)
        {
            char c = word.charAt(i);
            int index = chars.indexOf(Character.toString(c));
            float value = letterFrequency.get(Character.toString(c));

            if(value < 2)
                score += 150;
            if(value >=2 && value <= 6)
                score += 75;
            if(value > 6)
                score += 50;
        }

        return  score;
    }
}
