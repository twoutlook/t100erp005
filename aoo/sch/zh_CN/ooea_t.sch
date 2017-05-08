/* 
================================================================================
檔案代號:ooea_t
檔案名稱:組織基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooea_t
(
ooeaent       number(5)      ,/* 企業編號 */
ooeastus       varchar2(10)      ,/* 狀態碼 */
ooea001       varchar2(10)      ,/* 組織編號 */
ooea002       varchar2(10)      ,/* 法人歸屬 */
ooea003       varchar2(1)      ,/* 法人組織否 */
ooea004       varchar2(1)      ,/* 營運組織否 */
ooea005       varchar2(1)      ,/* 核算組織否 */
ooea006       varchar2(1)      ,/* 預算組織否 */
ooea007       varchar2(1)      ,/* 物流組織否 */
ooea008       varchar2(1)      ,/* 行政組織否 */
ooea009       varchar2(1)      ,/* 結算中心否 */
ooea010       varchar2(1)      ,/* 資產中心否 */
ooea011       varchar2(1)      ,/* 配送中心否 */
ooea012       varchar2(1)      ,/* 採購中心否 */
ooea013       varchar2(1)      ,/* 營銷中心否 */
ooea014       varchar2(1)      ,/* 門店否 */
ooea015       varchar2(1)      ,/* 辦事處否 */
ooea016       varchar2(1)      ,/* 部門否 */
ooea017       varchar2(1)      ,/* 地址識別碼 */
ooea018       varchar2(1)      ,/* 費用類型歸屬 */
ooea019       varchar2(1)      ,/* 屬性2 */
ooea020       varchar2(1)      ,/* 屬性3 */
ooea021       varchar2(1)      ,/* 屬性4 */
ooea022       varchar2(1)      ,/* 屬性5 */
ooea023       varchar2(1)      ,/* 屬性6 */
ooea024       varchar2(1)      ,/* 屬性7 */
ooea025       varchar2(1)      ,/* 屬性8 */
ooea026       varchar2(1)      ,/* 屬性9 */
ooea027       varchar2(1)      ,/* 屬性10 */
ooea028       varchar2(1)      ,/* 屬性11 */
ooea029       varchar2(1)      ,/* 屬性12 */
ooea030       varchar2(1)      ,/* 屬性13 */
ooea031       varchar2(1)      ,/* 屬性14 */
ooea032       varchar2(1)      ,/* 屬性15 */
ooea033       varchar2(1)      ,/* 屬性16 */
ooea034       varchar2(1)      ,/* 屬性17 */
ooea035       varchar2(1)      ,/* 屬性18 */
ooea036       varchar2(1)      ,/* 屬性19 */
ooea037       varchar2(1)      ,/* 屬性20 */
ooea038       varchar2(10)      ,/* 時區 */
ooea039       varchar2(10)      ,/* 稅區 */
ooea040       varchar2(10)      ,/* 統計貨幣 */
ooea041       varchar2(20)      ,/* 工商登記號 */
ooea042       varchar2(80)      ,/* 法人代表 */
ooea043       varchar2(80)      ,/* 註冊資本 */
ooeaownid       varchar2(20)      ,/* 資料所有者 */
ooeaowndp       varchar2(10)      ,/* 資料所屬部門 */
ooeacrtid       varchar2(20)      ,/* 資料建立者 */
ooeacrtdp       varchar2(10)      ,/* 資料建立部門 */
ooeacrtdt       timestamp(0)      ,/* 資料創建日 */
ooeamodid       varchar2(20)      ,/* 資料修改者 */
ooeamoddt       timestamp(0)      ,/* 最近修改日 */
ooeaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ooeaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ooeaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ooeaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ooeaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ooeaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ooeaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ooeaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ooeaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ooeaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ooeaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ooeaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ooeaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ooeaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ooeaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ooeaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ooeaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ooeaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ooeaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ooeaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ooeaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ooeaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ooeaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ooeaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ooeaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ooeaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ooeaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ooeaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ooeaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ooeaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ooea_t add constraint ooea_pk primary key (ooeaent,ooea001) enable validate;

create unique index ooea_pk on ooea_t (ooeaent,ooea001);

grant select on ooea_t to tiptop;
grant update on ooea_t to tiptop;
grant delete on ooea_t to tiptop;
grant insert on ooea_t to tiptop;

exit;
