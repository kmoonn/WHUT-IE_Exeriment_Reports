package com.example.mynote

import android.app.Activity
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ArrayAdapter
import android.widget.ImageView
import android.widget.TextView

class NewAdapter(activity: Activity, val resourceId: Int, data: List<New>) : ArrayAdapter<New>(activity, resourceId, data) {

    override fun getView(position: Int, convertView: View?, parent: ViewGroup): View {
        val view: View
        val viewHolder: ViewHolder
        if (convertView == null) {
            view = LayoutInflater.from(context).inflate(resourceId, parent, false)
            val newImage: ImageView = view.findViewById(R.id.newImage)
            val newName: TextView = view.findViewById(R.id.newName)
            viewHolder = ViewHolder(newImage, newName)
            view.tag = viewHolder
        } else {
            view = convertView
            viewHolder = view.tag as ViewHolder
        }

        val new = getItem(position)
        if (new != null) {
            viewHolder.newImage.setImageResource(new.imageId)
            viewHolder.newName.text = new.name
        }
        return view
    }

    inner class ViewHolder(val newImage: ImageView, val newName: TextView)

}