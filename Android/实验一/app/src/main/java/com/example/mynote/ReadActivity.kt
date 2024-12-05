package com.example.mynote

import android.content.Intent
import android.net.Uri
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import android.widget.Toast
import kotlinx.android.synthetic.main.activity_read.*

class ReadActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_read)
        val extraTitle = intent.getStringExtra("extra_title")
        val extraContent = intent.getStringExtra("extra_content")
        text_title.setText(extraTitle)
        text_content.setText(extraContent)
        button.setOnClickListener{
            Toast.makeText(applicationContext, "Back Succeed", Toast.LENGTH_SHORT).show()
            finish()
        }
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
            else -> super.onOptionsItemSelected(item)
        }
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.main,menu)
        return true
    }
}