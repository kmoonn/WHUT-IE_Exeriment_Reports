package com.example.mynote

import android.content.Context
import android.database.sqlite.SQLiteDatabase
import android.database.sqlite.SQLiteOpenHelper
import android.widget.Toast

class MyDatabaseHelper(val context: Context, name: String, version: Int) : SQLiteOpenHelper(context, name, null, version) {

    private val createNote = "create table Note(" +
            "id integer primary key autoincrement," +
            "title text," +
            "author text," +
            "content text," +
            "pic blob," +
            "date text)"

    override fun onCreate(db: SQLiteDatabase) {
        db.execSQL(createNote)
        Toast.makeText(context, "db create succeed",Toast.LENGTH_SHORT).show()
    }

    override fun onUpgrade(db: SQLiteDatabase, oldVersion: Int, newVersion: Int) {
        db.execSQL("drop table if exists Note")
        onCreate(db)
    }

}