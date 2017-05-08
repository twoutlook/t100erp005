/* 
================================================================================
檔案代號:stae_t
檔案名稱:費用編號基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table stae_t
(
staeent       number(5)      ,/* 企業編號 */
stae001       varchar2(10)      ,/* 費用編號 */
stae002       varchar2(10)      ,/* 進出類型 */
stae003       varchar2(10)      ,/* 費用總類 */
stae004       varchar2(10)      ,/* 費用性質 */
stae005       varchar2(10)      ,/* 核算制度 */
stae006       varchar2(10)      ,/* 價款類別 */
stae007       varchar2(1)      ,/* 可票扣 */
stae008       varchar2(10)      ,/* 關聯費用編號 */
stae009       varchar2(1)      ,/* 應開發票 */
stae010       varchar2(10)      ,/* 發票稅別 */
stae011       varchar2(1)      ,/* 納入計算單否 */
staeownid       varchar2(20)      ,/* 資料所有者 */
staeowndp       varchar2(10)      ,/* 資料所有部門 */
staecrtid       varchar2(20)      ,/* 資料建立者 */
staecrtdp       varchar2(10)      ,/* 資料建立部門 */
staecrtdt       timestamp(0)      ,/* 資料創建日 */
staemodid       varchar2(20)      ,/* 資料修改者 */
staemoddt       timestamp(0)      ,/* 最近修改日 */
staestus       varchar2(10)      ,/* 狀態碼 */
staeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
staeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
staeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
staeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
staeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
staeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
staeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
staeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
staeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
staeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
staeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
staeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
staeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
staeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
staeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
staeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
staeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
staeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
staeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
staeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
staeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
staeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
staeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
staeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
staeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
staeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
staeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
staeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
staeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
staeud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stae012       varchar2(10)      /* 費用用途類型 */
);
alter table stae_t add constraint stae_pk primary key (staeent,stae001) enable validate;

create unique index stae_pk on stae_t (staeent,stae001);

grant select on stae_t to tiptop;
grant update on stae_t to tiptop;
grant delete on stae_t to tiptop;
grant insert on stae_t to tiptop;

exit;
