/* 
================================================================================
檔案代號:xcae_t
檔案名稱:成本工藝路線主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcae_t
(
xcaeent       number(5)      ,/* 企業編號 */
xcaeownid       varchar2(20)      ,/* 資料所有者 */
xcaeowndp       varchar2(10)      ,/* 資料所屬部門 */
xcaecrtid       varchar2(20)      ,/* 資料建立者 */
xcaecrtdp       varchar2(10)      ,/* 資料建立部門 */
xcaecrtdt       timestamp(0)      ,/* 資料創建日 */
xcaemodid       varchar2(20)      ,/* 資料修改者 */
xcaemoddt       timestamp(0)      ,/* 最近修改日 */
xcaestus       varchar2(10)      ,/* 狀態碼 */
xcaesite       varchar2(10)      ,/* 營運據點 */
xcae001       varchar2(10)      ,/* 版本 */
xcae002       varchar2(40)      ,/* 製程料號 */
xcaeseq       number(10,0)      ,/* 項次 */
xcae003       number(10,0)      ,/* 工藝序 */
xcae004       varchar2(10)      ,/* 作業編號 */
xcae005       varchar2(10)      ,/* 工作站 */
xcae006       varchar2(1)      ,/* 委外否 */
xcae008       varchar2(10)      ,/* 製程編號 */
xcaeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcaeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcaeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcaeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcaeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcaeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcaeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcaeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcaeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcaeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcaeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcaeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcaeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcaeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcaeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcaeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcaeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcaeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcaeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcaeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcaeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcaeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcaeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcaeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcaeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcaeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcaeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcaeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcaeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcaeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcae_t add constraint xcae_pk primary key (xcaeent,xcae001,xcae002,xcaeseq) enable validate;

create unique index xcae_pk on xcae_t (xcaeent,xcae001,xcae002,xcaeseq);

grant select on xcae_t to tiptop;
grant update on xcae_t to tiptop;
grant delete on xcae_t to tiptop;
grant insert on xcae_t to tiptop;

exit;
