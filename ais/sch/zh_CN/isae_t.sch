/* 
================================================================================
檔案代號:isae_t
檔案名稱:發票簿資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table isae_t
(
isaeent       number(5)      ,/* 企業編號 */
isaecomp       varchar2(10)      ,/* 法人 */
isaeownid       varchar2(20)      ,/* 資料所有者 */
isaeowndp       varchar2(10)      ,/* 資料所屬部門 */
isaecrtid       varchar2(20)      ,/* 資料建立者 */
isaecrtdp       varchar2(10)      ,/* 資料建立部門 */
isaecrtdt       timestamp(0)      ,/* 資料創建日 */
isaemodid       varchar2(20)      ,/* 資料修改者 */
isaemoddt       timestamp(0)      ,/* 最近修改日 */
isaestus       varchar2(10)      ,/* 狀態碼 */
isaesite       varchar2(10)      ,/* 營運據點 */
isae001       varchar2(10)      ,/* 發票簿號 */
isae002       date      ,/* 生效日期 */
isae003       date      ,/* 失效日期 */
isae004       varchar2(2)      ,/* 發票類型 */
isae005       varchar2(1)      ,/* 電子發票否 */
isae006       varchar2(1)      ,/* 開立方式 */
isae007       varchar2(20)      ,/* 發票字軌 */
isae008       varchar2(20)      ,/* 發票代碼 */
isae009       varchar2(20)      ,/* 起始號碼 */
isae010       varchar2(20)      ,/* 結束號碼 */
isae011       number(10,0)      ,/* 發票張數 */
isae012       varchar2(20)      ,/* 下次列印號碼 */
isae013       number(5,0)      ,/* 已使用張數 */
isae014       date      ,/* 已列印發票日期 */
isae015       varchar2(1)      ,/* 下傳 pos否 */
isae016       number(5,0)      ,/* 年度 */
isae017       number(5,0)      ,/* 起始月份 */
isae018       number(5,0)      ,/* 結束月份 */
isae019       varchar2(10)      ,/* 資料來源 */
isae020       number(20,6)      ,/* 發票限額 */
isaeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isaeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isaeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isaeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isaeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isaeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isaeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isaeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isaeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isaeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isaeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isaeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isaeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isaeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isaeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isaeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isaeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isaeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isaeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isaeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isaeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isaeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isaeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isaeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isaeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isaeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isaeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isaeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isaeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isaeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table isae_t add constraint isae_pk primary key (isaeent,isaecomp,isaesite,isae001,isae002,isae003,isae004,isae016,isae017,isae018) enable validate;

create unique index isae_pk on isae_t (isaeent,isaecomp,isaesite,isae001,isae002,isae003,isae004,isae016,isae017,isae018);

grant select on isae_t to tiptop;
grant update on isae_t to tiptop;
grant delete on isae_t to tiptop;
grant insert on isae_t to tiptop;

exit;
