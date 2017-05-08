/* 
================================================================================
檔案代號:mmcu_t
檔案名稱:會員等級升降策略單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mmcu_t
(
mmcuent       number(5)      ,/* 企業編號 */
mmcuunit       varchar2(10)      ,/* 應用組織 */
mmcu001       varchar2(30)      ,/* 升降等策略編號 */
mmcu002       varchar2(10)      ,/* 版本 */
mmcu003       varchar2(80)      ,/* 升降等策略說明 */
mmcu004       varchar2(1)      ,/* 跨級升降等 */
mmcu005       varchar2(1)      ,/* 允許降等 */
mmcuownid       varchar2(20)      ,/* 資料所有者 */
mmcuowndp       varchar2(10)      ,/* 資料所屬部門 */
mmcucrtid       varchar2(20)      ,/* 資料建立者 */
mmcucrtdp       varchar2(10)      ,/* 資料建立部門 */
mmcucrtdt       timestamp(0)      ,/* 資料創建日 */
mmcumodid       varchar2(20)      ,/* 資料修改者 */
mmcumoddt       timestamp(0)      ,/* 最近修改日 */
mmcustus       varchar2(10)      ,/* 狀態碼 */
mmcucnfid       varchar2(20)      ,/* 資料確認者 */
mmcucnfdt       timestamp(0)      ,/* 資料確認日 */
mmcuud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmcuud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmcuud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmcuud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmcuud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmcuud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmcuud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmcuud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmcuud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmcuud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmcuud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmcuud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmcuud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmcuud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmcuud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmcuud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmcuud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmcuud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmcuud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmcuud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmcuud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmcuud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmcuud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmcuud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmcuud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmcuud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmcuud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmcuud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmcuud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmcuud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmcu_t add constraint mmcu_pk primary key (mmcuent,mmcu001) enable validate;

create unique index mmcu_pk on mmcu_t (mmcuent,mmcu001);

grant select on mmcu_t to tiptop;
grant update on mmcu_t to tiptop;
grant delete on mmcu_t to tiptop;
grant insert on mmcu_t to tiptop;

exit;
