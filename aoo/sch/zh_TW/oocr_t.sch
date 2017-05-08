/* 
================================================================================
檔案代號:oocr_t
檔案名稱:關連標籤檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oocr_t
(
oocr001       varchar2(10)      ,/* 應用分類碼 */
oocr002       varchar2(10)      ,/* 主標籤編號 */
oocr003       varchar2(10)      ,/* 關聯標籤編號 */
oocrent       number(5)      ,/* 企業編號 */
oocrstus       varchar2(10)      ,/* 狀態碼 */
oocrownid       varchar2(20)      ,/* 資料所有者 */
oocrowndp       varchar2(10)      ,/* 資料所屬部門 */
oocrcrtid       varchar2(20)      ,/* 資料建立者 */
oocrcrtdp       varchar2(10)      ,/* 資料建立部門 */
oocrcrtdt       timestamp(0)      ,/* 資料創建日 */
oocrmodid       varchar2(20)      ,/* 資料修改者 */
oocrmoddt       timestamp(0)      ,/* 最近修改日 */
oocrud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oocrud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oocrud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oocrud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oocrud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oocrud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oocrud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oocrud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oocrud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oocrud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oocrud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oocrud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oocrud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oocrud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oocrud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oocrud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oocrud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oocrud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oocrud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oocrud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oocrud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oocrud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oocrud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oocrud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oocrud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oocrud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oocrud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oocrud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oocrud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oocrud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oocr_t add constraint oocr_pk primary key (oocr001,oocr002,oocr003,oocrent) enable validate;

create unique index oocr_pk on oocr_t (oocr001,oocr002,oocr003,oocrent);

grant select on oocr_t to tiptop;
grant update on oocr_t to tiptop;
grant delete on oocr_t to tiptop;
grant insert on oocr_t to tiptop;

exit;
