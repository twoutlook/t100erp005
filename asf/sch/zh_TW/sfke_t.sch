/* 
================================================================================
檔案代號:sfke_t
檔案名稱:工單變更單計畫完工日期檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfke_t
(
sfkeent       number(5)      ,/* 企業編號 */
sfkesite       varchar2(10)      ,/* 營運據點 */
sfkedocno       varchar2(20)      ,/* 工單單號 */
sfkeseq       number(10,0)      ,/* 項次 */
sfke001       number(20,6)      ,/* 數量 */
sfke002       date      ,/* 預計完工日期 */
sfke003       date      ,/* 累計數量達成日 */
sfke004       number(5,0)      ,/* 修正次數 */
sfke005       varchar2(20)      ,/* 修改人員 */
sfke006       date      ,/* 修改日期 */
sfke900       number(10,0)      ,/* 變更序 */
sfke901       varchar2(1)      ,/* 變更類型 */
sfke902       date      ,/* 變更日期 */
sfke905       varchar2(10)      ,/* 變更理由 */
sfke906       varchar2(255)      ,/* 變更備註 */
sfkeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfkeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfkeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfkeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfkeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfkeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfkeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfkeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfkeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfkeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfkeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfkeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfkeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfkeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfkeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfkeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfkeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfkeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfkeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfkeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfkeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfkeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfkeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfkeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfkeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfkeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfkeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfkeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfkeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfkeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfke_t add constraint sfke_pk primary key (sfkeent,sfkedocno,sfkeseq,sfke900) enable validate;

create unique index sfke_pk on sfke_t (sfkeent,sfkedocno,sfkeseq,sfke900);

grant select on sfke_t to tiptop;
grant update on sfke_t to tiptop;
grant delete on sfke_t to tiptop;
grant insert on sfke_t to tiptop;

exit;
