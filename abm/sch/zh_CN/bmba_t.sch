/* 
================================================================================
檔案代號:bmba_t
檔案名稱:產品結構研發資料單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmba_t
(
bmbaent       number(5)      ,/* 企業編號 */
bmbasite       varchar2(10)      ,/* 營運據點 */
bmba001       varchar2(40)      ,/* 主件料號 */
bmba002       varchar2(30)      ,/* 特性 */
bmba003       varchar2(40)      ,/* 元件料號 */
bmba004       varchar2(10)      ,/* 部位編號 */
bmba005       timestamp(0)      ,/* 生效日期時間 */
bmba006       timestamp(0)      ,/* 失效日期時間 */
bmba007       varchar2(10)      ,/* 作業編號 */
bmba008       varchar2(10)      ,/* 作業序 */
bmba009       number(10,0)      ,/* 項次 */
bmba010       varchar2(10)      ,/* 發料單位 */
bmba011       number(20,6)      ,/* 組成用量 */
bmba012       number(20,6)      ,/* 主件底數 */
bmba013       varchar2(10)      ,/* 必要 */
bmba014       varchar2(1)      ,/* 特徵管理 */
bmba015       varchar2(10)      ,/* 指定發料庫位 */
bmba016       varchar2(10)      ,/* 指定發料儲位 */
bmba017       varchar2(10)      ,/* FAS選擇群組 */
bmba018       varchar2(1)      ,/* 插件位置 */
bmba019       varchar2(10)      ,/* 參照研發中心 */
bmba020       varchar2(1)      ,/* 可選件 */
bmba021       varchar2(10)      ,/* 工單展開選項 */
bmba022       varchar2(1)      ,/* 代買料 */
bmba023       number(15,3)      ,/* 元件投料時距 */
bmba024       varchar2(40)      ,/* 主要替代料 */
bmba025       varchar2(1)      ,/* 附屬零件 */
bmba026       varchar2(20)      ,/* ECN單號 */
bmba027       varchar2(1)      ,/* 用量是否使用公式 */
bmba028       varchar2(10)      ,/* 用量公式 */
bmba029       varchar2(10)      ,/* 損耗率型態 */
bmba030       varchar2(1)      ,/* 倒扣料 */
bmba031       varchar2(1)      ,/* 客供料 */
bmba032       varchar2(30)      ,/* 指定庫存管理特徵 */
bmbaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmbaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmbaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmbaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmbaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmbaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmbaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmbaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmbaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmbaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmbaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmbaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmbaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmbaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmbaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmbaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmbaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmbaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmbaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmbaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmbaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmbaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmbaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmbaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmbaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmbaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmbaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmbaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmbaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmbaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
bmba033       varchar2(1)      ,/* 損耗率是否使用公式 */
bmba034       varchar2(10)      /* 損耗率公式 */
);
alter table bmba_t add constraint bmba_pk primary key (bmbaent,bmbasite,bmba001,bmba002,bmba003,bmba004,bmba005,bmba007,bmba008) enable validate;

create  index bmba_01 on bmba_t (bmba001,bmba002,bmba003,bmba004,bmba005,bmba007,bmba008);
create  index bmba_n02 on bmba_t (bmba003,bmbaent,bmba005);
create unique index bmba_pk on bmba_t (bmbaent,bmbasite,bmba001,bmba002,bmba003,bmba004,bmba005,bmba007,bmba008);

grant select on bmba_t to tiptop;
grant update on bmba_t to tiptop;
grant delete on bmba_t to tiptop;
grant insert on bmba_t to tiptop;

exit;
