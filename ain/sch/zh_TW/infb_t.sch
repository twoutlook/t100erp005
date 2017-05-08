/* 
================================================================================
檔案代號:infb_t
檔案名稱:貨架編號申請單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table infb_t
(
infbent       number(5)      ,/* 企業編碼 */
infbsite       varchar2(10)      ,/* 營運據點 */
infbunit       varchar2(10)      ,/* 應用組織 */
infbdocno       varchar2(20)      ,/* 單據編號 */
infbseq       number(10,0)      ,/* 項次 */
infb001       varchar2(10)      ,/* 貨架編號 */
infb002       varchar2(10)      ,/* 貨架類型 */
infb003       number(5,0)      ,/* 層數 */
infb004       number(5,0)      ,/* 列數 */
infb005       number(15,3)      ,/* 長度 */
infb006       number(15,3)      ,/* 寬度 */
infb007       number(15,3)      ,/* 高度 */
infb008       varchar2(80)      ,/* 備註 */
infbstus       varchar2(10)      ,/* 狀態 */
infbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
infbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
infbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
infbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
infbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
infbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
infbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
infbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
infbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
infbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
infbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
infbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
infbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
infbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
infbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
infbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
infbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
infbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
infbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
infbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
infbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
infbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
infbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
infbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
infbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
infbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
infbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
infbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
infbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
infbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table infb_t add constraint infb_pk primary key (infbent,infbdocno,infbseq) enable validate;

create unique index infb_pk on infb_t (infbent,infbdocno,infbseq);

grant select on infb_t to tiptop;
grant update on infb_t to tiptop;
grant delete on infb_t to tiptop;
grant insert on infb_t to tiptop;

exit;
