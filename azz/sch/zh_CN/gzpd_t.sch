/* 
================================================================================
檔案代號:gzpd_t
檔案名稱:排程實際執行依時細項
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table gzpd_t
(
gzpdent       number(5)      ,/* 企業編號 */
gzpd001       varchar2(40)      ,/* 排程執行序號 */
gzpd002       varchar2(40)      ,/* 排程編號 */
gzpd003       number(5,0)      ,/* 序號 */
gzpd004       varchar2(20)      ,/* 執行作業 */
gzpd005       varchar2(500)      ,/* 傳入參數 */
gzpd006       varchar2(10)      ,/* 執行營運據點 */
gzpd007       varchar2(1)      ,/* 作業執行狀態 */
gzpd008       timestamp(0)      ,/* 作業執行時間 */
gzpd009       varchar2(20)      ,/* 執行使用者編號 */
gzpd010       timestamp(0)      ,/* 作業完成時間 */
gzpd011       number(5,0)      ,/* 執行順序 */
gzpd012       varchar2(20)      ,/* sessionkey */
gzpdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzpdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzpdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzpdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzpdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzpdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzpdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzpdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzpdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzpdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzpdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzpdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzpdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzpdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzpdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzpdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzpdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzpdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzpdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzpdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzpdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzpdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzpdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzpdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzpdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzpdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzpdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzpdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzpdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzpdud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
gzpd013       varchar2(20)      ,/* PID */
gzpd014       varchar2(20)      /* 任務執行主機 */
);
alter table gzpd_t add constraint gzpd_pk primary key (gzpdent,gzpd001,gzpd003) enable validate;

create unique index gzpd_pk on gzpd_t (gzpdent,gzpd001,gzpd003);

grant select on gzpd_t to tiptop;
grant update on gzpd_t to tiptop;
grant delete on gzpd_t to tiptop;
grant insert on gzpd_t to tiptop;

exit;
