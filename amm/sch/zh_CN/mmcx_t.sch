/* 
================================================================================
檔案代號:mmcx_t
檔案名稱:會員等級變更單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table mmcx_t
(
mmcxent       number(5)      ,/* 企業編號 */
mmcxunit       varchar2(10)      ,/* 營運據點 */
mmcxsite       varchar2(10)      ,/* 營運據點 */
mmcxdocno       varchar2(20)      ,/* 單號 */
mmcxdocdt       date      ,/* 單據日期 */
mmcx001       varchar2(30)      ,/* 理由碼 */
mmcx002       date      ,/* 統計截止日期 */
mmcxownid       varchar2(20)      ,/* 資料所有者 */
mmcxowndp       varchar2(10)      ,/* 資料所屬部門 */
mmcxcrtid       varchar2(20)      ,/* 資料建立者 */
mmcxcrtdp       varchar2(10)      ,/* 資料建立部門 */
mmcxcrtdt       timestamp(0)      ,/* 資料創建日 */
mmcxmodid       varchar2(20)      ,/* 資料修改者 */
mmcxmoddt       timestamp(0)      ,/* 最近修改日 */
mmcxcnfid       varchar2(20)      ,/* 資料確認者 */
mmcxcnfdt       timestamp(0)      ,/* 資料確認日 */
mmcxstus       varchar2(10)      ,/* 狀態碼 */
mmcxud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmcxud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmcxud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmcxud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmcxud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmcxud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmcxud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmcxud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmcxud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmcxud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmcxud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmcxud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmcxud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmcxud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmcxud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmcxud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmcxud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmcxud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmcxud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmcxud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmcxud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmcxud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmcxud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmcxud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmcxud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmcxud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmcxud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmcxud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmcxud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmcxud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmcx_t add constraint mmcx_pk primary key (mmcxent,mmcxdocno) enable validate;

create unique index mmcx_pk on mmcx_t (mmcxent,mmcxdocno);

grant select on mmcx_t to tiptop;
grant update on mmcx_t to tiptop;
grant delete on mmcx_t to tiptop;
grant insert on mmcx_t to tiptop;

exit;
