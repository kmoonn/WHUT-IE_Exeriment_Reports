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

    private val newList = ArrayList<New>()

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
            val title = new.name
            val intent = Intent(this,ReadActivity::class.java)
            intent.putExtra("extra_title",title)
            val content = new.content
            intent.putExtra("extra_content",content)
            startActivity(intent)
        }
    }

    private fun initNews() {
            newList.add(New("强化稳岗扩就业政策支持", R.drawable.flag,"    去年城镇调查失业率一度明显攀升。财税、金融、投资等政策更加注重稳就业·对困难行业企业社保费实施缓缴大幅提高失业保险基金稳岗返还比例，增加稳岗扩岗补助。落实担保贷款、租金减免等创业支持政策。突出做好高校毕业生就业工作，开展就业困难人员专项帮扶·在重点工程建设中推广以工代赈脱贫人口务工规模超过3200万人、实现稳中有增。就业形势总体保持稳定。"))
            newList.add(New("以粮食和能源为重点做好保供稳价", R.drawable.flag,"    去年全球通胀达到40多年来新高，国内价格稳定面临较大压力。。有效应对洪涝、干旱等严重自然灾害，不误农时抢抓粮食播种和收获，督促和协调农机通行，保障农事活动有序开展，分三批向种粮农民发放农资补贴，保障粮食丰收和重要农产品稳定供给·发挥煤炭主体能源作用，增加煤炭先进产能，加大对发电供热企业支持力度，保障能源正常供应在全球高通胀的背景下，我国物价保持较低水平，尤为难得。"))
            newList.add(New("强化基本民生保障", R.drawable.flag,"   阶段性扩大低保等社会保障政策覆盖面，将更多困难群体纳入保障范围延续实施失业保险保障扩围政策共向1000多万失业人员发放失业保险待遇向更多低收入群众发放价格补贴，约6700万人受益免除经济困难高校毕业生2022年国家助学贷款利息并允许延期还本做好因疫因灾遇困群众临时救助工作，切实兜住民生底线与此同时我们全面落实中央经济工作会议部署，按照十三届全国人大五次会议批准的政府工作报告安排,统筹推进经济社会各领域工作。经过艰苦努力，当前消费需求、市场流通、工业生产、企业预期等明显向好，经济增长正在企稳向上，我国经济有巨大潜力和发展动力。"))
            newList.add(New("经济发展再上新台阶", R.drawable.flag,"    国内生产总值增加到121万亿财政收入增元，五年年均增长5.2%，十年加到20.4万增加近70万亿元、年均增长亿元 6.2%,在高基数基础上实现了中高速增长、迈向高质量发展粮食产量连年稳定在工业增加值突破40万 1.3万亿斤以上亿元城镇新增就业年均外汇储备稳定在3万 1270多万人亿美元以上我国经济实力明显提升。"))
            newList.add(New("脱贫攻坚任务顺利完成", R.drawable.flag,"    经过八年持续努力·近1亿农村贫困人口实现脱贫·全国832个贫困县全部摘帽·960多万贫困人☐实现易地搬迁历史性地解决了绝对贫困问题。"))
            newList.add(New("科技创新成果丰硕", R.drawable.flag,"    构建新型举国体制，组建国家实验室，分批推进全国重点实验室重组些关键核心技术攻关取得新突破，载人航天、探月探火、深海深地探测、超级计算机、卫星导航、量子信息、核电技术、大飞机制造、人工智能等领域创新成果不断涌现全社会研发经费投入强度从2.1%提高到2.5%以上，科技进步贡献率提高到60%以上，创新支撑发展能力不断增强。"))
            newList.add(New("经济结构进一步优化", R.drawable.flag,"    高技术制造业、装备制造业增加值年均分别增长10.6%、7.9%，数字经济不断壮大，新产业新业态新模式增加值占国内生产总值的比重达到17%以上·区域协调发展战略、区域重大战略深入实施·常住人口城镇化率从60.2%提高到 65.2%,乡村振兴战略全面实施经济发展新动能加快成长。"))
            newList.add(New("基础设施更加完善", R.drawable.flag,"    一批防汛抗旱、引水高速铁路运营里程从调水等重大水利工程 2.5万公里增加到4.2开工建设万公里，高速公路里程从13.6万公里增加到17.7万公里新建改建农村公路新增机场容量4亿人 125万公里次发电装机容量增长所有地级市实现干兆 40%以上光网覆盖，所有行政村实现通宽带。"))
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