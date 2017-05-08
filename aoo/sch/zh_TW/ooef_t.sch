/* 
================================================================================
檔案代號:ooef_t
檔案名稱:組織基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooef_t
(
ooefent       number(5)      ,/* 企業編號 */
ooefstus       varchar2(10)      ,/* 狀態碼 */
ooef001       varchar2(10)      ,/* 組織編號 */
ooef002       varchar2(20)      ,/* 統一編號 */
ooef004       varchar2(5)      ,/* 單據別參照表號 */
ooef005       varchar2(5)      ,/* 單據據點編號 */
ooef006       varchar2(10)      ,/* 所屬國家地區 */
ooef007       varchar2(10)      ,/* 上市櫃公司編號 */
ooef008       varchar2(5)      ,/* 行事曆參照表號 */
ooef009       varchar2(10)      ,/* 製造行事曆對應類別 */
ooef010       varchar2(10)      ,/* 辦公行事曆對應類別 */
ooef011       varchar2(10)      ,/* 專屬國家地區功能 */
ooef012       varchar2(20)      ,/* 聯絡對象識別碼 */
ooef013       varchar2(10)      ,/* 日期顯示格式 */
ooefownid       varchar2(20)      ,/* 資料所有者 */
ooefowndp       varchar2(10)      ,/* 資料所有部門 */
ooefcrtid       varchar2(20)      ,/* 資料建立者 */
ooefcrtdp       varchar2(10)      ,/* 資料建立部門 */
ooefcrtdt       timestamp(0)      ,/* 資料創建日 */
ooefmodid       varchar2(20)      ,/* 資料修改者 */
ooefmoddt       timestamp(0)      ,/* 最近修改日 */
ooef014       varchar2(5)      ,/* 幣別參照表號 */
ooef015       varchar2(5)      ,/* 匯率參照表號 */
ooef016       varchar2(10)      ,/* 主幣別編號 */
ooef017       varchar2(10)      ,/* 法人歸屬 */
ooef018       varchar2(10)      ,/* 時區 */
ooef019       varchar2(10)      ,/* 稅區 */
ooef020       varchar2(20)      ,/* 工商登記號 */
ooef021       varchar2(80)      ,/* 法人代表 */
ooef022       varchar2(80)      ,/* 註冊資本 */
ooef003       varchar2(10)      ,/* 法人否 */
ooef023       varchar2(10)      ,/* 數字/金額顯示格式 */
ooef024       varchar2(10)      ,/* 據點對應客戶/供應商編號 */
ooef025       varchar2(5)      ,/* 品管參照表號 */
ooef026       varchar2(15)      ,/* 預設存款銀行帳戶 */
ooef100       varchar2(10)      ,/* 門店狀態 */
ooef101       varchar2(10)      ,/* 層級類型 */
ooef102       varchar2(10)      ,/* 業態 */
ooef103       varchar2(10)      ,/* 通路 */
ooef104       varchar2(10)      ,/* 商圈 */
ooef105       varchar2(10)      ,/* 可比店 */
ooef106       varchar2(10)      ,/* 價格參考標準 */
ooef107       varchar2(255)      ,/* 店慶會計期 */
ooef108       varchar2(10)      ,/* 散客編號 */
ooef109       date      ,/* 開業日期 */
ooef110       date      ,/* 閉店日期 */
ooef111       number(20,6)      ,/* 測量面積 */
ooef112       number(20,6)      ,/* 建築面積 */
ooef113       number(20,6)      ,/* 經營面積 */
ooef114       number(5,0)      ,/* 合作對象總數 */
ooef115       varchar2(1)      ,/* 24小時營業否 */
ooef120       number(20,6)      ,/* 本店取貨訂定比例 */
ooef121       number(20,6)      ,/* 異店取貨訂定比例 */
ooef122       number(20,6)      ,/* 總部配送訂定比例 */
ooef123       varchar2(10)      ,/* 預設收貨成本倉 */
ooef124       varchar2(10)      ,/* 預設出貨成本倉 */
ooef125       varchar2(10)      ,/* 預設在途成本倉 */
ooef150       varchar2(10)      ,/* 門店類別 */
ooef151       varchar2(10)      ,/* 規模類別 */
ooef152       varchar2(10)      ,/* 門店週期 */
ooef153       varchar2(10)      ,/* 銷售區域 */
ooef154       varchar2(10)      ,/* 銷售省區 */
ooef155       varchar2(10)      ,/* 銷售地區 */
ooef156       varchar2(10)      ,/* 銷售片區 */
ooef157       varchar2(10)      ,/* 其他屬性1 */
ooef158       varchar2(10)      ,/* 其他屬性2 */
ooef159       varchar2(10)      ,/* 其他屬性3 */
ooef160       varchar2(10)      ,/* 其他屬性4 */
ooef161       varchar2(10)      ,/* 其他屬性5 */
ooef162       varchar2(10)      ,/* 其他屬性6 */
ooef163       varchar2(10)      ,/* 其他屬性7 */
ooef164       varchar2(10)      ,/* 其他屬性8 */
ooef165       varchar2(10)      ,/* 其他屬性9 */
ooef166       varchar2(10)      ,/* 其他屬性10 */
ooef167       varchar2(10)      ,/* 其他屬性11 */
ooef168       varchar2(10)      ,/* 其他屬性12 */
ooef169       varchar2(10)      ,/* 其他屬性13 */
ooef170       varchar2(10)      ,/* 其他屬性14 */
ooef171       varchar2(10)      ,/* 其他屬性15 */
ooef172       varchar2(10)      ,/* 其他屬性16 */
ooef173       varchar2(10)      ,/* 其他屬性17 */
ooefunit       varchar2(10)      ,/* 應用組織 */
ooef200       varchar2(10)      ,/* 分群編號 */
ooef201       varchar2(1)      ,/* 營運據點 */
ooef202       varchar2(1)      ,/* 預測組織 */
ooef203       varchar2(1)      ,/* 部門組織 */
ooef204       varchar2(1)      ,/* 核算組織 */
ooef205       varchar2(1)      ,/* 預算組織 */
ooef206       varchar2(1)      ,/* 資金組織 */
ooef207       varchar2(1)      ,/* 資產組織 */
ooef208       varchar2(1)      ,/* 銷售組織 */
ooef209       varchar2(1)      ,/* 銷售範圍 */
ooef210       varchar2(1)      ,/* 採購組織 */
ooef211       varchar2(1)      ,/* 物流組織 */
ooef212       varchar2(1)      ,/* 結算組織 */
ooef213       varchar2(1)      ,/* nouse */
ooef214       varchar2(1)      ,/* nouse */
ooef215       varchar2(1)      ,/* nouse */
ooef216       varchar2(1)      ,/* nouse */
ooef217       varchar2(1)      ,/* nouse */
ooef301       varchar2(1)      ,/* 營銷中心 */
ooef302       varchar2(1)      ,/* 配送中心 */
ooef303       varchar2(1)      ,/* 採購中心 */
ooef304       varchar2(1)      ,/* 門店 */
ooef305       varchar2(1)      ,/* 辦事處 */
ooef306       varchar2(1)      ,/* nouse */
ooef307       varchar2(1)      ,/* nouse */
ooef308       varchar2(1)      ,/* nouse */
ooef309       varchar2(1)      ,/* nouse */
ooef310       varchar2(1)      ,/* nouse */
ooef126       varchar2(10)      ,/* 預設收貨非成本倉 */
ooef127       varchar2(10)      ,/* 預設出貨非成本倉 */
ooef128       varchar2(10)      ,/* 預設在途非成本倉 */
ooef116       varchar2(10)      /* 語言別 */
);
alter table ooef_t add constraint ooef_pk primary key (ooefent,ooef001) enable validate;

create  index ooef_01 on ooef_t (ooef007);
create unique index ooef_pk on ooef_t (ooefent,ooef001);

grant select on ooef_t to tiptop;
grant update on ooef_t to tiptop;
grant delete on ooef_t to tiptop;
grant insert on ooef_t to tiptop;

exit;
