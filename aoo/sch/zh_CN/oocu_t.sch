/* 
================================================================================
檔案代號:oocu_t
檔案名稱:材積重設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oocu_t
(
oocuent       number(5)      ,/* 企業編號 */
oocu001       varchar2(10)      ,/* 材積編號 */
oocu002       varchar2(10)      ,/* 制度 */
oocu003       number(20,6)      ,/* 乘數 */
oocu004       number(20,6)      ,/* 除數 */
oocuownid       varchar2(20)      ,/* 資料所有者 */
oocuowndp       varchar2(10)      ,/* 資料所屬部門 */
oocucrtid       varchar2(20)      ,/* 資料建立者 */
oocucrtdp       varchar2(10)      ,/* 資料建立部門 */
oocucrtdt       timestamp(0)      ,/* 資料創建日 */
oocumodid       varchar2(20)      ,/* 資料修改者 */
oocumoddt       timestamp(0)      ,/* 最近修改日 */
oocustus       varchar2(10)      ,/* 狀態碼 */
oocuud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oocuud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oocuud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oocuud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oocuud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oocuud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oocuud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oocuud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oocuud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oocuud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oocuud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oocuud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oocuud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oocuud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oocuud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oocuud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oocuud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oocuud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oocuud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oocuud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oocuud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oocuud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oocuud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oocuud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oocuud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oocuud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oocuud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oocuud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oocuud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oocuud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oocu_t add constraint oocu_pk primary key (oocuent,oocu001) enable validate;

create unique index oocu_pk on oocu_t (oocuent,oocu001);

grant select on oocu_t to tiptop;
grant update on oocu_t to tiptop;
grant delete on oocu_t to tiptop;
grant insert on oocu_t to tiptop;

exit;
