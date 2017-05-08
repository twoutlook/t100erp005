/* 
================================================================================
檔案代號:glej_t
檔案名稱:合併現金流量表間接法活動科目設定資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glej_t
(
glejent       number(5)      ,/* 企業編號 */
glejld       varchar2(5)      ,/* 合併帳別 */
glej001       varchar2(10)      ,/* 上層公司 */
glej002       varchar2(10)      ,/* 群組代碼 */
glej003       varchar2(24)      ,/* 科目編號 */
glej004       varchar2(1)      ,/* 加/減項 */
glej005       varchar2(1)      ,/* 異動類型 */
glej006       varchar2(1)      ,/* 有效碼 */
glejownid       varchar2(20)      ,/* 資料所有者 */
glejowndp       varchar2(10)      ,/* 資料所屬部門 */
glejcrtid       varchar2(20)      ,/* 資料建立者 */
glejcrtdp       varchar2(10)      ,/* 資料建立部門 */
glejcrtdt       timestamp(0)      ,/* 資料創建日 */
glejmodid       varchar2(20)      ,/* 資料修改者 */
glejmoddt       timestamp(0)      ,/* 最近修改日 */
glejstus       varchar2(10)      ,/* 狀態碼 */
glejud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glejud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glejud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glejud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glejud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glejud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glejud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glejud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glejud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glejud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glejud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glejud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glejud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glejud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glejud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glejud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glejud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glejud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glejud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glejud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glejud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glejud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glejud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glejud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glejud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glejud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glejud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glejud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glejud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glejud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glej_t add constraint glej_pk primary key (glejent,glejld,glej001,glej002,glej003) enable validate;

create unique index glej_pk on glej_t (glejent,glejld,glej001,glej002,glej003);

grant select on glej_t to tiptop;
grant update on glej_t to tiptop;
grant delete on glej_t to tiptop;
grant insert on glej_t to tiptop;

exit;
