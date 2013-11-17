package com.utils;

import android.content.ContentValues;
import android.content.Context;
import android.content.res.AssetFileDescriptor;
import android.content.res.AssetManager;
import android.content.res.Resources;
import android.os.Environment;
import android.test.suitebuilder.annotation.SmallTest;
import android.util.Log;
import com.main.R;

import java.io.*;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 8/8/11
 * Time: 6:50 PM
 */
public class GameDictionaryHashMap
{
    public static final String DICTIONARY_FILE_NAME = "dictionary.ser";
    public static Map dictionaryMap;

    public static  void writeToFile(Context context)
    {
        /*
             //read the csv into the new database
         //this requires there to be a dictionary.csv file in the raw directory
        InputStream inputStream = getResources().openRawResource(R.raw.dictionary);
        BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));

        try
        {
           String word;//word
           int primaryKey = 0;//primary key
           Map dictionaryHash = new HashMap();

           while ((word = reader.readLine()) != null)
           {
               dictionaryHash.put(primaryKey,word );
               primaryKey++;

               if(primaryKey % 1000 == 0)
               {
                   Log.v("Percent load completed ", " " + primaryKey);
                   myLabel.setText("Percent load completed " + primaryKey);
               }
           }

            //write the dictionary to a file
            File file = new File(DICTIONARY_FILE_NAME);
            BufferedOutputStream fos = new BufferedOutputStream(new FileOutputStream(getFilesDir() +"/"+ DICTIONARY_FILE_NAME));
            ObjectOutputStream oos = new ObjectOutputStream(fos);
            oos.writeObject(dictionaryHash);
            oos.flush();
            oos.close();


            //FileInputStream fis = new FileInputStream(getFilesDir() +"/"+DICTIONARY_FILE_NAME);
            //ObjectInputStream ois = new ObjectInputStream(fis);
            //Map dictionaryMap = (Map) ois.readObject();

            //ois.close();

       }
       catch (Exception ex) {
           // handle exception
           Log.v(ex.getMessage(), "message");
       }
       finally
        {
           try
           {
               inputStream.close();

           }
           catch (IOException e) {
               // handle exception
              Log.v(e.getMessage(), "message");
           }
       }
         */
    }

    public static void readDictionaryHashFile(Context context)
    {
        try
        {
            dictionaryMap = null; //object to be deserialized
            InputStream is = null;
            ObjectInputStream ois=null;
            AssetManager assets = context.getAssets();
            is = assets.open(DICTIONARY_FILE_NAME);
            ois = new ObjectInputStream(is);
            dictionaryMap = (Map) ois.readObject();
            ois.close();
        }
        catch (Exception e){
            Log.v(e.getMessage(), "message");
        }

    }

    public static  void writeToSDCard(Context context)
    {
        /*
        //this requires there to be a dictionary.csv file in the raw directory
        InputStream inputStream = context.getResources().openRawResource(R.raw.dictionary);
        BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));

        try
        {
           String word;//word
           int primaryKey = 0;//primary key
           Map dictionaryHash = new HashMap();

           while ((word = reader.readLine()) != null)
           {
               if(word.length() < 7)
               {
                   dictionaryHash.put(primaryKey,word );
                   primaryKey++;

                   if(primaryKey % 1000 == 0)
                       Log.v("Percent load completed ", " " + primaryKey);
               }
           }

            //write the dictionary to a file
            File file = new File(DICTIONARY_FILE_NAME);
            BufferedOutputStream fos = new BufferedOutputStream(new FileOutputStream(Environment.getExternalStorageDirectory() +"/"+ DICTIONARY_FILE_NAME));
            ObjectOutputStream oos = new ObjectOutputStream(fos);
            oos.writeObject(dictionaryHash);
            oos.flush();
            oos.close();

       }
       catch (Exception ex) {
           // handle exception
           Log.v(ex.getMessage(), "message");
       }
       finally
        {
           try
           {
               inputStream.close();

           }
           catch (IOException e) {
               // handle exception
              Log.v(e.getMessage(), "message");
           }
       }
       */
    }

    //is this a word?
    public static  boolean contains(String _possibleWord)
    {
        return dictionaryMap.containsValue(_possibleWord);
    }
}
