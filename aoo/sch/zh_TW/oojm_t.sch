/* 
================================================================================
檔案代號:oojm_t
檔案名稱:組織基本資料申請單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:Y
============.========================.==========================================
 */
create table oojm_t
(
oojment       number(5)      ,/* 企業編號 */
oojmsite       varchar2(10)      ,/* 營運據點 */
oojmunit       varchar2(10)      ,/* 應用組織 */
oojmdocno       varchar2(20)      ,/* 單據編號 */
oojm000       varchar2(10)      ,/* 資料類型 */
oojm001       varchar2(10)      ,/* 組織編號 */
oojm002       varchar2(20)      ,/* 稅籍編號 */
oojm003       varchar2(10)      ,/* 法人否 */
oojm004       varchar2(5)      ,/* 單據別參照表號 */
oojm005       varchar2(5)      ,/* 單據據點代號 */
oojm006       varchar2(10)      ,/* 所屬國家地區 */
oojm007       varchar2(10)      ,/* 上市櫃公司代號 */
oojm008       varchar2(5)      ,/* 行事曆參照表號 */
oojm009       varchar2(10)      ,/* 製造行事曆對應類別 */
oojm010       varchar2(10)      ,/* 辦公行事曆對應類別 */
oojm011       varchar2(10)      ,/* 專屬國家地區功能 */
oojm012       varchar2(20)      ,/* 聯絡對象識別碼 */
oojm013       varchar2(10)      ,/* 日期顯示格式 */
oojm014       varchar2(5)      ,/* 幣別參照表 */
oojm015       varchar2(5)      ,/* 匯率參照表號 */
oojm016       varchar2(10)      ,/* 主幣別編號 */
oojm017       varchar2(10)      ,/* 法人歸屬 */
oojm018       varchar2(10)      ,/* 時區 */
oojm019       varchar2(10)      ,/* 稅區 */
oojm020       varchar2(20)      ,/* 工商登記號 */
oojm021       varchar2(80)      ,/* 法人代表 */
oojm022       varchar2(80)      ,/* 註冊資本 */
oojm023       varchar2(10)      ,/* 數字/金額顯示格式 */
oojm024       varchar2(10)      ,/* 據點對應客戶/廠商編號 */
oojm025       varchar2(5)      ,/* 品管參照表號 */
oojm200       varchar2(10)      ,/* 分群編號 */
oojm201       varchar2(1)      ,/* 營運組織 */
oojm202       varchar2(1)      ,/* 預測組織 */
oojm203       varchar2(1)      ,/* 部門組織 */
oojm204       varchar2(1)      ,/* 核算組織 */
oojm205       varchar2(1)      ,/* 預算組織 */
oojm206       varchar2(1)      ,/* 資金組織 */
oojm207       varchar2(1)      ,/* 資產組織 */
oojm208       varchar2(1)      ,/* 銷售組織 */
oojm209       varchar2(1)      ,/* 銷售範圍 */
oojm210       varchar2(1)      ,/* 採購組織 */
oojm211       varchar2(1)      ,/* 物流組織 */
oojm212       varchar2(1)      ,/* 結算組織 */
oojm213       varchar2(1)      ,/* nouse */
oojm214       varchar2(1)      ,/* nouse */
oojm215       varchar2(1)      ,/* nouse */
oojm216       varchar2(1)      ,/* nouse */
oojm217       varchar2(1)      ,/* nouse */
oojm301       varchar2(1)      ,/* 營銷中心 */
oojm302       varchar2(1)      ,/* 配送中心 */
oojm303       varchar2(1)      ,/* 採購中心 */
oojm304       varchar2(1)      ,/* 門店 */
oojm305       varchar2(1)      ,/* 辦事處 */
oojm306       varchar2(1)      ,/* nouse */
oojm307       varchar2(1)      ,/* nouse */
oojm308       varchar2(1)      ,/* nouse */
oojm309       varchar2(1)      ,/* nouse */
oojm310       varchar2(1)      ,/* nouse */
oojm401       varchar2(10)      ,/* 銷售範圍所屬組織 */
oojm402       varchar2(10)      ,/* 銷售渠道 */
oojm403       varchar2(10)      ,/* 產品組編號 */
oojm404       varchar2(10)      ,/* 銷售範圍所屬辦事處 */
oojmacti       varchar2(1)      ,/* 資料有效 */
oojm405       varchar2(10)      ,/* 預設收貨成本倉 */
oojm406       varchar2(10)      ,/* 預設出貨成本倉 */
oojm407       varchar2(10)      ,/* 預設在途成本倉 */
oojm408       varchar2(10)      ,/* 預設收貨非成本倉 */
oojm409       varchar2(10)      ,/* 預設出貨非成本倉 */
oojm410       varchar2(10)      ,/* 預設在途非成本倉 */
oojmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oojmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oojmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oojmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oojmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oojmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oojmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oojmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oojmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oojmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oojmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oojmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oojmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oojmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oojmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oojmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oojmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oojmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oojmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oojmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oojmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oojmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oojmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oojmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oojmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oojmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oojmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oojmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oojmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oojmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oojm_t add constraint oojm_pk primary key (oojment,oojmdocno,oojm001) enable validate;

create unique index oojm_pk on oojm_t (oojment,oojmdocno,oojm001);

grant select on oojm_t to tiptop;
grant update on oojm_t to tiptop;
grant delete on oojm_t to tiptop;
grant insert on oojm_t to tiptop;

exit;
