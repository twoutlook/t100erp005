/* 
================================================================================
檔案代號:oogd_t
檔案名稱:班別檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oogd_t
(
oogdent       number(5)      ,/* 企業編號 */
oogdstus       varchar2(10)      ,/* 狀態碼 */
oogd001       varchar2(10)      ,/* 班別編號 */
oogd002       varchar2(80)      ,/* 班別說明 */
oogd003       varchar2(8)      ,/* 上班時間 */
oogd004       varchar2(8)      ,/* 下班時間 */
oogd005       number(15,3)      ,/* 標準休息時間 */
oogd006       number(15,3)      ,/* 可工作時數 */
oogdsite       varchar2(10)      ,/* 營運據點 */
oogdownid       varchar2(20)      ,/* 資料所有者 */
oogdowndp       varchar2(10)      ,/* 資料所屬部門 */
oogdcrtid       varchar2(20)      ,/* 資料建立者 */
oogdcrtdp       varchar2(10)      ,/* 資料建立部門 */
oogdcrtdt       timestamp(0)      ,/* 資料創建日 */
oogdmodid       varchar2(20)      ,/* 資料修改者 */
oogdmoddt       timestamp(0)      ,/* 最近修改日 */
oogdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oogdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oogdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oogdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oogdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oogdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oogdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oogdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oogdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oogdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oogdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oogdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oogdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oogdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oogdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oogdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oogdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oogdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oogdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oogdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oogdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oogdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oogdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oogdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oogdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oogdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oogdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oogdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oogdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oogdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oogd_t add constraint oogd_pk primary key (oogdent,oogd001,oogdsite) enable validate;

create unique index oogd_pk on oogd_t (oogdent,oogd001,oogdsite);

grant select on oogd_t to tiptop;
grant update on oogd_t to tiptop;
grant delete on oogd_t to tiptop;
grant insert on oogd_t to tiptop;

exit;
