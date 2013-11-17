package com.example;

import android.app.Activity;
import android.content.res.AssetFileDescriptor;
import android.content.res.AssetManager;
import android.os.Bundle;
import android.os.Environment;
import android.provider.ContactsContract;
import android.util.Log;
import android.widget.TextView;

import java.io.*;
import java.util.HashMap;
import java.util.Map;

public class MyActivity extends Activity
{
    public  final String DICTIONARY_FILE_NAME = "dictionarys.ser";
    private TextView myLabel;

    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        myLabel = (TextView) findViewById(R.id.label);
        //writeToFile();
        //writeToSDCard();

       /*  */

     readFile();
    }

    private void readFile()
    {
        try
        {
            Map data = null; //object to be deserialized
            InputStream is = null;
            ObjectInputStream ois=null;
            AssetManager assets = getAssets();
            is = assets.open(DICTIONARY_FILE_NAME);
            ois = new ObjectInputStream(is);
            data = (Map) ois.readObject();
            ois.close();
        }
        catch (Exception e){
            Log.v(e.getMessage(), "message");
        }

    }

    private void writeToFile()
    {
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

    }

    private void writeToSDCard()
    {
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
                     Log.v("alldone","done");
              /*
            FileInputStream fis = new FileInputStream(getFilesDir() +"/"+DICTIONARY_FILE_NAME);
            ObjectInputStream ois = new ObjectInputStream(fis);
            Map dictionaryMap = (Map) ois.readObject();
            ois.close();  */

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
    }
}
