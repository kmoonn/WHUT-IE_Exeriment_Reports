package com.example.mynote

import android.content.Intent
import android.graphics.BitmapFactory
import android.net.Uri
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import kotlinx.android.synthetic.main.activity_read.*


class ReadActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_read)
        initNews()
        button.setOnClickListener{
            Toast.makeText(applicationContext, "Back Succeed", Toast.LENGTH_SHORT).show()
            finish()
        }
    }

    private fun initNews(){
        val dbHelper = MyDatabaseHelper(this, "Note.db",1)
        val db = dbHelper.writableDatabase
        val id = intent.getIntExtra("id",1).toString()
        var title = "title"
        var author = "Hushan"
        var content = "Hello"
        var date = "20230320"
        val cursor = db.query("Note", null,"id=$id",null ,null,null,null)
        if(cursor.moveToNext()){
            title = cursor.getString(cursor.getColumnIndex("title"))
            author = cursor.getString(cursor.getColumnIndex("author"))
            content = cursor.getString(cursor.getColumnIndex("content"))
            date = cursor.getString(cursor.getColumnIndex("date"))
        }
        cursor.close()
        text_author.setText(author)
        text_title.setText(title)
        text_content.setText(content)
        time.setText(date)
        val bitmap = BitmapFactory.decodeFile("/sdcard/Android/data/com.example.mynote/cache/image_"+id+".jpg")
        imageView2.setImageBitmap(bitmap)
    }


    private fun deleteNote(){
        val dbHelper = MyDatabaseHelper(this, "Note.db",1)
        val db = dbHelper.writableDatabase
        val id = intent.getIntExtra("id",1).toString()
        db.use {
            db.execSQL("delete from Note where id = $id")
        }
        db.close()
    }


    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        return when (item.itemId) {
            R.id.action_exit -> {
                Toast.makeText(this,"Exit Succeed", Toast.LENGTH_SHORT).show()
                finish()
                true
            }
            R.id.action_website -> {
                val intent = Intent(Intent.ACTION_VIEW)
                intent.data = Uri.parse("https://www.gov.cn")
                startActivity(intent)
                true
            }
            R.id.delete_item-> {
                deleteNote()
                Toast.makeText(this,"删除成功",Toast.LENGTH_SHORT).show()
                val intent = Intent(this,MainActivity::class.java)
                startActivity(intent)
                finish()
                true
            }
            else -> super.onOptionsItemSelected(item)
        }
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.delete,menu)
        return true
    }
}