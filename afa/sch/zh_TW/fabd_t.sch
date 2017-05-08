/* 
================================================================================
檔案代號:fabd_t
檔案名稱:折畢再提單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fabd_t
(
fabdent       number(5)      ,/* 企業編號 */
fabdld       varchar2(10)      ,/* 帳套 */
fabddocno       varchar2(20)      ,/* 折畢再提單號 */
fabdseq       number(10,0)      ,/* 項次 */
fabd000       varchar2(10)      ,/* 卡片編號 */
fabd001       varchar2(20)      ,/* 財產編號 */
fabd002       varchar2(20)      ,/* 附號 */
fabd003       varchar2(10)      ,/* 主要類別 */
fabd004       varchar2(10)      ,/* 次要類別 */
fabd005       varchar2(1)      ,/* 資產狀態 */
fabd006       varchar2(1)      ,/* 折畢再提否 */
fabd007       number(10,0)      ,/* 再提年限（月） */
fabd008       varchar2(10)      ,/* 幣別 */
fabd009       number(20,10)      ,/* 匯率 */
fabd010       number(20,6)      ,/* 折畢殘值 */
fabd011       number(10)      ,/* 單據性質 */
fabd101       varchar2(10)      ,/* 本位幣二幣別 */
fabd102       number(20,10)      ,/* 本位幣二匯率 */
fabd103       number(20,6)      ,/* 本位幣二折畢殘值 */
fabd150       varchar2(10)      ,/* 本位幣三幣別 */
fabd151       number(20,10)      ,/* 本位幣三匯率 */
fabd152       number(20,6)      ,/* 本位幣三折畢殘值 */
fabdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fabdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fabdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fabdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fabdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fabdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fabdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fabdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fabdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fabdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fabdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fabdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fabdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fabdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fabdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fabdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fabdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fabdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fabdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fabdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fabdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fabdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fabdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fabdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fabdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fabdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fabdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fabdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fabdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fabdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fabd_t add constraint fabd_pk primary key (fabdent,fabdld,fabddocno,fabdseq) enable validate;

create unique index fabd_pk on fabd_t (fabdent,fabdld,fabddocno,fabdseq);

grant select on fabd_t to tiptop;
grant update on fabd_t to tiptop;
grant delete on fabd_t to tiptop;
grant insert on fabd_t to tiptop;

exit;
