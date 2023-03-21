package com.example.mynote

import android.content.Intent
import android.net.Uri
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import android.widget.Toast
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    private var newList = ArrayList<New>()
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        initNews()
        val adapter = NewAdapter(this, R.layout.new_item, newList)
        listView.adapter = adapter
        listView.setOnItemClickListener { parent, view, position, id ->
        }
        listView.setOnItemClickListener { _, _, position, _ ->
            val new = newList[position]
            Toast.makeText(this, "正在加载", Toast.LENGTH_SHORT).show()
            val id = new.id
            val intent = Intent(this,ReadActivity::class.java)
            intent.putExtra("id",id)
            startActivity(intent)
        }
    }

    private var dbHelper = MyDatabaseHelper(this,"Note.db",1)

    private fun initNews() {
        val db = dbHelper.writableDatabase
        val cursor = db.query("Note",null,null,null,null,null,"id DESC")
        if(cursor.moveToFirst()){
            do {
                val id = cursor.getInt(cursor.getColumnIndex("id"))
                val title = cursor.getString(cursor.getColumnIndex("title"))
                newList.add(New(id, title, R.drawable.flag))
            }while (cursor.moveToNext())
        }
        cursor.close()
        db.close()
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        return when (item.itemId) {
            R.id.action_exit -> {
                Toast.makeText(this,"Exit Succeed",Toast.LENGTH_SHORT).show()
                finish()
                true
            }
            R.id.action_website -> {
                val intent = Intent(Intent.ACTION_VIEW)
                intent.data = Uri.parse("https://www.gov.cn")
                startActivity(intent)
                true
            }
            R.id.action_write -> {
                val intent = Intent(this,WriteActivity::class.java)
                startActivity(intent)
                true
            }
            else -> super.onOptionsItemSelected(item)
        }
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.main,menu)
        return true
    }
}