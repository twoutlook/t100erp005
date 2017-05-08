/* 
================================================================================
檔案代號:ooca_t
檔案名稱:單位資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooca_t
(
oocastus       varchar2(10)      ,/* 狀態碼 */
oocaent       number(5)      ,/* 企業編號 */
ooca001       varchar2(10)      ,/* 單位編號 */
ooca002       number(5,0)      ,/* 小數位數 */
ooca003       varchar2(10)      ,/* 單位類型 */
ooca004       varchar2(10)      ,/* 捨入類型 */
ooca005       varchar2(10)      ,/* ISO代碼 */
ooca006       varchar2(10)      ,/* 面積單位 */
ooca007       varchar2(10)      ,/* 體積單位 */
oocaownid       varchar2(20)      ,/* 資料所有者 */
oocaowndp       varchar2(10)      ,/* 資料所屬部門 */
oocacrtid       varchar2(20)      ,/* 資料建立者 */
oocacrtdp       varchar2(10)      ,/* 資料建立部門 */
oocacrtdt       timestamp(0)      ,/* 資料創建日 */
oocamodid       varchar2(20)      ,/* 資料修改者 */
oocamoddt       timestamp(0)      ,/* 最近修改日 */
oocaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oocaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oocaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oocaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oocaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oocaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oocaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oocaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oocaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oocaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oocaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oocaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oocaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oocaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oocaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oocaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oocaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oocaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oocaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oocaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oocaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oocaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oocaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oocaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oocaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oocaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oocaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oocaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oocaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oocaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ooca_t add constraint ooca_pk primary key (oocaent,ooca001) enable validate;

create unique index ooca_pk on ooca_t (oocaent,ooca001);

grant select on ooca_t to tiptop;
grant update on ooca_t to tiptop;
grant delete on ooca_t to tiptop;
grant insert on ooca_t to tiptop;

exit;
