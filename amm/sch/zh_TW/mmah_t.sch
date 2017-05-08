/* 
================================================================================
檔案代號:mmah_t
檔案名稱:會員基本資料檔-紀念日
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmah_t
(
mmahent       number(5)      ,/* 企業編號 */
mmah001       varchar2(30)      ,/* 會員編號 */
mmah002       varchar2(10)      ,/* 紀念日代碼 */
mmah003       date      ,/* 紀念日期 */
mmah004       varchar2(10)      ,/* 紀念日期-年 */
mmah005       varchar2(10)      ,/* 紀念日期-月 */
mmah006       varchar2(10)      ,/* 紀念日期-日 */
mmahstus       varchar2(10)      ,/* 狀態碼 */
mmahud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmahud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmahud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmahud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmahud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmahud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmahud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmahud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmahud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmahud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmahud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmahud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmahud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmahud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmahud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmahud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmahud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmahud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmahud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmahud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmahud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmahud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmahud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmahud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmahud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmahud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmahud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmahud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmahud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmahud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmah_t add constraint mmah_pk primary key (mmahent,mmah001,mmah002) enable validate;

create unique index mmah_pk on mmah_t (mmahent,mmah001,mmah002);

grant select on mmah_t to tiptop;
grant update on mmah_t to tiptop;
grant delete on mmah_t to tiptop;
grant insert on mmah_t to tiptop;

exit;
