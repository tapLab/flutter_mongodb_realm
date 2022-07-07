package com.example.flutter_mongo_realm.streamHandlers

import android.os.Handler

import io.flutter.plugin.common.EventChannel
import org.bson.BsonValue
import org.bson.Document
import android.os.Looper
import com.example.flutter_mongo_realm.MyMongoRealmClient
import io.realm.internal.events.ChangeEvent


class StreamHandler(val client: MyMongoRealmClient, val arguments: Any?)
    : EventChannel.StreamHandler {

    private lateinit var handler: Handler
    private var eventSink: EventChannel.EventSink? = null

    override fun onListen(o: Any, eventSink: EventChannel.EventSink) {
        this.eventSink = eventSink
        //runnable.run()

        val args = arguments as Map<*, *>
        val dbName = args["db"] as? String
        val collectionName = args["collection"] as? String
        val filter = args["filter"] as? String
        val ids = args["ids"] as? List<String>
        val asObjectIds = args["as_object_ids"] as? Boolean

        val task = this.client.watchCollection(dbName,collectionName, filter, ids, asObjectIds ?: true)

        task?.get {
            val event = it.get()

            if (event != null) {


//            changeStream?.addChangeEventListener { documentId: BsonValue, event: ChangeEvent<Document> ->
//                // handle change event

                handler = Handler(Looper.getMainLooper())
                handler.post {
//                      eventSink.success(mapOf(
//                          "id" to event.fullDocument?.get("_id"),
//                          "fullDocumentJson" to event.fullDocument?.toJson()
//                      ))
                      eventSink.success(event.fullDocument?.toJson())

                }
            }

//            }
        }
    }

    override fun onCancel(o: Any) {
        handler.removeCallbacks {  }
    }
}
