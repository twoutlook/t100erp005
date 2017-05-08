/* 
================================================================================
檔案代號:bxad_t
檔案名稱:委外加工核准函檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bxad_t
(
bxadent       number(5)      ,/* 企業編號 */
bxadsite       varchar2(10)      ,/* 營運據點 */
bxad001       varchar2(10)      ,/* 核准函號碼 */
bxad002       varchar2(10)      ,/* 供應商編號 */
bxad003       date      ,/* 申請日期 */
bxad004       date      ,/* 截止日期 */
bxad005       varchar2(1)      ,/* 是否展延 */
bxadownid       varchar2(20)      ,/* 資料所有者 */
bxadowndp       varchar2(10)      ,/* 資料所屬部門 */
bxadcrtid       varchar2(20)      ,/* 資料建立者 */
bxadcrtdp       varchar2(10)      ,/* 資料建立部門 */
bxadcrtdt       timestamp(0)      ,/* 資料創建日 */
bxadmodid       varchar2(20)      ,/* 資料修改者 */
bxadmoddt       timestamp(0)      ,/* 最近修改日 */
bxadstus       varchar2(10)      ,/* 狀態碼 */
bxadud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bxadud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bxadud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bxadud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bxadud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bxadud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bxadud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bxadud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bxadud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bxadud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bxadud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bxadud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bxadud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bxadud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bxadud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bxadud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bxadud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bxadud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bxadud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bxadud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bxadud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bxadud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bxadud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bxadud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bxadud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bxadud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bxadud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bxadud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bxadud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bxadud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bxad_t add constraint bxad_pk primary key (bxadent,bxadsite,bxad001) enable validate;

create unique index bxad_pk on bxad_t (bxadent,bxadsite,bxad001);

grant select on bxad_t to tiptop;
grant update on bxad_t to tiptop;
grant delete on bxad_t to tiptop;
grant insert on bxad_t to tiptop;

exit;
