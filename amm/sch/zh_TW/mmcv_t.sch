/* 
================================================================================
檔案代號:mmcv_t
檔案名稱:會員等級升降策略單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmcv_t
(
mmcvent       number(5)      ,/* 企業編號 */
mmcv001       varchar2(30)      ,/* 升降等策略編號 */
mmcv002       varchar2(10)      ,/* 會員等級編號 */
mmcv003       number(10,0)      ,/* 組別 */
mmcv004       number(10,0)      ,/* 序號 */
mmcv005       varchar2(10)      ,/* 會員升等條件 */
mmcv006       number(5,0)      ,/* 統計區間(月) */
mmcv007       number(20,6)      ,/* 下限 */
mmcv008       number(20,6)      ,/* 上限 */
mmcvstus       varchar2(1)      ,/* 資料有效 */
mmcvud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmcvud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmcvud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmcvud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmcvud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmcvud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmcvud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmcvud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmcvud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmcvud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmcvud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmcvud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmcvud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmcvud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmcvud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmcvud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmcvud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmcvud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmcvud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmcvud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmcvud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmcvud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmcvud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmcvud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmcvud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmcvud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmcvud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmcvud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmcvud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmcvud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmcv_t add constraint mmcv_pk primary key (mmcvent,mmcv001,mmcv002,mmcv003,mmcv004) enable validate;

create unique index mmcv_pk on mmcv_t (mmcvent,mmcv001,mmcv002,mmcv003,mmcv004);

grant select on mmcv_t to tiptop;
grant update on mmcv_t to tiptop;
grant delete on mmcv_t to tiptop;
grant insert on mmcv_t to tiptop;

exit;
