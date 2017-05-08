/* 
================================================================================
檔案代號:glav_t
檔案名稱:會計週期資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glav_t
(
glavent       number(5)      ,/* 企業編號 */
glav001       varchar2(5)      ,/* 會計週期參照表號 */
glav002       number(5,0)      ,/* 年度 */
glav003       varchar2(1)      ,/* 週期種類 */
glav004       date      ,/* 日期 */
glav005       number(5,0)      ,/* 歸屬季別 */
glav006       number(5,0)      ,/* 歸屬期別 */
glav007       number(5,0)      ,/* 歸屬週別 */
glavownid       varchar2(20)      ,/* 資料所有者 */
glavowndp       varchar2(10)      ,/* 資料所屬部門 */
glavcrtid       varchar2(20)      ,/* 資料建立者 */
glavcrtdp       varchar2(10)      ,/* 資料建立部門 */
glavcrtdt       timestamp(0)      ,/* 資料創建日 */
glavmodid       varchar2(20)      ,/* 資料修改者 */
glavmoddt       timestamp(0)      ,/* 最近修改日 */
glavstus       varchar2(10)      ,/* 狀態碼 */
glavud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glavud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glavud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glavud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glavud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glavud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glavud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glavud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glavud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glavud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glavud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glavud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glavud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glavud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glavud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glavud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glavud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glavud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glavud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glavud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glavud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glavud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glavud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glavud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glavud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glavud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glavud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glavud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glavud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glavud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glav_t add constraint glav_pk primary key (glavent,glav001,glav002,glav004) enable validate;

create unique index glav_pk on glav_t (glavent,glav001,glav002,glav004);

grant select on glav_t to tiptop;
grant update on glav_t to tiptop;
grant delete on glav_t to tiptop;
grant insert on glav_t to tiptop;

exit;
