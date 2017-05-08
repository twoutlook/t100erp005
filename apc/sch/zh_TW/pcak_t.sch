/* 
================================================================================
檔案代號:pcak_t
檔案名稱:POS門店機號參數資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pcak_t
(
pcakent       number(5)      ,/* 企業編號 */
pcakunit       varchar2(10)      ,/* 應用組織 */
pcaksite       varchar2(10)      ,/* 營運據點 */
pcak001       varchar2(10)      ,/* 機號 */
pcak002       varchar2(60)      ,/* 參數編號 */
pcak003       varchar2(60)      ,/* 參數值 */
pcakstamp       timestamp(5)      ,/* 時間戳記 */
pcakstus       varchar2(10)      ,/* 狀態碼 */
pcakownid       varchar2(20)      ,/* 資料所有者 */
pcakowndp       varchar2(10)      ,/* 資料所屬部門 */
pcakcrtid       varchar2(20)      ,/* 資料建立者 */
pcakcrtdp       varchar2(10)      ,/* 資料建立部門 */
pcakcrtdt       timestamp(0)      ,/* 資料創建日 */
pcakmodid       varchar2(20)      ,/* 資料修改者 */
pcakmoddt       timestamp(0)      ,/* 最近修改日 */
pcakud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pcakud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pcakud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pcakud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pcakud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pcakud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pcakud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pcakud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pcakud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pcakud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pcakud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pcakud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pcakud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pcakud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pcakud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pcakud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pcakud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pcakud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pcakud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pcakud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pcakud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pcakud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pcakud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pcakud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pcakud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pcakud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pcakud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pcakud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pcakud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pcakud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pcak_t add constraint pcak_pk primary key (pcakent,pcaksite,pcak001,pcak002) enable validate;

create unique index pcak_pk on pcak_t (pcakent,pcaksite,pcak001,pcak002);

grant select on pcak_t to tiptop;
grant update on pcak_t to tiptop;
grant delete on pcak_t to tiptop;
grant insert on pcak_t to tiptop;

exit;
