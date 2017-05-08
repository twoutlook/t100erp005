/* 
================================================================================
檔案代號:inph_t
檔案名稱:ABC分類資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table inph_t
(
inphent       number(5)      ,/* 企業編號 */
inphsite       varchar2(10)      ,/* 營運據點 */
inph001       varchar2(1)      ,/* ABC計算方式 */
inph002       number(5,0)      ,/* 過去期間 */
inph003       varchar2(1)      ,/* 計算基準 */
inph004       varchar2(1)      ,/* 成本來源 */
inph005       number(20,6)      ,/* A類分配百分比 */
inph006       number(20,6)      ,/* B類分配百分比 */
inph007       varchar2(1)      ,/* 分類類型 */
inph008       number(20,6)      ,/* A類值 */
inph009       number(20,6)      ,/* B類值 */
inph010       number(20,6)      ,/* C類值 */
inph011       varchar2(255)      ,/* 備註 */
inphownid       varchar2(20)      ,/* 資料所有者 */
inphowndp       varchar2(10)      ,/* 資料所屬部門 */
inphcrtid       varchar2(20)      ,/* 資料建立者 */
inphcrtdp       varchar2(10)      ,/* 資料建立部門 */
inphcrtdt       timestamp(0)      ,/* 資料創建日 */
inphmodid       varchar2(20)      ,/* 資料修改者 */
inphmoddt       timestamp(0)      ,/* 最近修改日 */
inphud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inphud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inphud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inphud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inphud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inphud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inphud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inphud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inphud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inphud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inphud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inphud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inphud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inphud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inphud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inphud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inphud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inphud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inphud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inphud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inphud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inphud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inphud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inphud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inphud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inphud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inphud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inphud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inphud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inphud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inph_t add constraint inph_pk primary key (inphent,inphsite) enable validate;

create unique index inph_pk on inph_t (inphent,inphsite);

grant select on inph_t to tiptop;
grant update on inph_t to tiptop;
grant delete on inph_t to tiptop;
grant insert on inph_t to tiptop;

exit;
