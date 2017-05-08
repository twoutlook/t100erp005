/* 
================================================================================
檔案代號:mmai_t
檔案名稱:會員基本資料檔-訊息喜好類型
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmai_t
(
mmaient       number(5)      ,/* 企業編號 */
mmai001       varchar2(30)      ,/* 會員編號 */
mmai002       varchar2(10)      ,/* 喜好類型代碼 */
mmaistus       varchar2(10)      ,/* 狀態碼 */
mmaiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmaiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmaiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmaiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmaiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmaiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmaiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmaiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmaiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmaiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmaiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmaiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmaiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmaiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmaiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmaiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmaiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmaiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmaiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmaiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmaiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmaiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmaiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmaiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmaiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmaiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmaiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmaiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmaiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmaiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmai_t add constraint mmai_pk primary key (mmaient,mmai001,mmai002) enable validate;

create unique index mmai_pk on mmai_t (mmaient,mmai001,mmai002);

grant select on mmai_t to tiptop;
grant update on mmai_t to tiptop;
grant delete on mmai_t to tiptop;
grant insert on mmai_t to tiptop;

exit;
