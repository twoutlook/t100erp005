/* 
================================================================================
檔案代號:isax_t
檔案名稱:電子發票列印異動紀錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table isax_t
(
isaxent       number(5)      ,/* 企業代碼 */
isaxseq       number(10,0)      ,/* 項次 */
isax001       varchar2(20)      ,/* 總公司統一編號 */
isax002       number(5,0)      ,/* 發票所屬年度 */
isax003       number(5,0)      ,/* 發票所屬月份 */
isax004       varchar2(20)      ,/* 發票代碼 */
isax005       varchar2(20)      ,/* 發票號碼 */
isax006       varchar2(80)      ,/* 載具顯碼ID */
isax007       varchar2(10)      ,/* 異動原因 */
isax008       varchar2(1)      ,/* 異動類型 */
isax009       date      ,/* 異動日期 */
isax010       varchar2(20)      ,/* 異動人員 */
isax011       timestamp(0)      ,/* 異動時間 */
isaxcomp       varchar2(10)      ,/* 法人 */
isaxsite       varchar2(10)      ,/* 營運據點 */
isaxud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isaxud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isaxud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isaxud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isaxud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isaxud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isaxud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isaxud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isaxud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isaxud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isaxud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isaxud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isaxud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isaxud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isaxud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isaxud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isaxud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isaxud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isaxud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isaxud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isaxud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isaxud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isaxud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isaxud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isaxud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isaxud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isaxud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isaxud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isaxud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isaxud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table isax_t add constraint isax_pk primary key (isaxent,isaxseq,isax001,isax002,isax003) enable validate;

create unique index isax_pk on isax_t (isaxent,isaxseq,isax001,isax002,isax003);

grant select on isax_t to tiptop;
grant update on isax_t to tiptop;
grant delete on isax_t to tiptop;
grant insert on isax_t to tiptop;

exit;
