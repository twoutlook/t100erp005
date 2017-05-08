/* 
================================================================================
檔案代號:bxdj_t
檔案名稱:保稅機器設備收回單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table bxdj_t
(
bxdjent       number(5)      ,/* 企業代碼 */
bxdjsite       varchar2(10)      ,/* 營運據點 */
bxdjdocno       varchar2(20)      ,/* 收回單號 */
bxdjdocdt       date      ,/* 單據日期 */
bxdj001       varchar2(20)      ,/* 申請人員 */
bxdj002       varchar2(10)      ,/* 申請部門 */
bxdj010       varchar2(255)      ,/* 備註 */
bxdjownid       varchar2(20)      ,/* 資料所有者 */
bxdjowndp       varchar2(10)      ,/* 資料所屬部門 */
bxdjcrtid       varchar2(20)      ,/* 資料建立者 */
bxdjcrtdp       varchar2(10)      ,/* 資料建立部門 */
bxdjcrtdt       timestamp(0)      ,/* 資料創建日 */
bxdjmodid       varchar2(20)      ,/* 資料修改者 */
bxdjmoddt       timestamp(0)      ,/* 最近修改日 */
bxdjstus       varchar2(10)      ,/* 狀態碼 */
bxdjcnfid       varchar2(20)      ,/* 資料確認者 */
bxdjcnfdt       timestamp(0)      ,/* 資料確認日 */
bxdjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bxdjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bxdjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bxdjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bxdjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bxdjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bxdjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bxdjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bxdjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bxdjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bxdjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bxdjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bxdjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bxdjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bxdjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bxdjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bxdjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bxdjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bxdjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bxdjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bxdjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bxdjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bxdjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bxdjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bxdjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bxdjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bxdjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bxdjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bxdjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bxdjud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bxdj_t add constraint bxdj_pk primary key (bxdjent,bxdjdocno) enable validate;

create unique index bxdj_pk on bxdj_t (bxdjent,bxdjdocno);

grant select on bxdj_t to tiptop;
grant update on bxdj_t to tiptop;
grant delete on bxdj_t to tiptop;
grant insert on bxdj_t to tiptop;

exit;
