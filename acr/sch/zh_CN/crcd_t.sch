/* 
================================================================================
檔案代號:crcd_t
檔案名稱:客戶調查問卷答案明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table crcd_t
(
crcdent       number(5)      ,/* 企業編號 */
crcdstus       varchar2(1)      ,/* 狀態 */
crcd001       varchar2(10)      ,/* 調查問卷編號 */
crcd002       varchar2(10)      ,/* 問題編號 */
crcd003       varchar2(10)      ,/* 答案編號 */
crcd004       varchar2(500)      ,/* 答案內容 */
crcd005       number(15,3)      ,/* 得分 */
crcdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
crcdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
crcdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
crcdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
crcdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
crcdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
crcdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
crcdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
crcdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
crcdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
crcdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
crcdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
crcdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
crcdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
crcdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
crcdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
crcdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
crcdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
crcdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
crcdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
crcdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
crcdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
crcdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
crcdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
crcdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
crcdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
crcdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
crcdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
crcdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
crcdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table crcd_t add constraint crcd_pk primary key (crcdent,crcd001,crcd002,crcd003) enable validate;

create unique index crcd_pk on crcd_t (crcdent,crcd001,crcd002,crcd003);

grant select on crcd_t to tiptop;
grant update on crcd_t to tiptop;
grant delete on crcd_t to tiptop;
grant insert on crcd_t to tiptop;

exit;
