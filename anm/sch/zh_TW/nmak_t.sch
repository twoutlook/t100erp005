/* 
================================================================================
檔案代號:nmak_t
檔案名稱:現金異動碼分類編碼
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table nmak_t
(
nmakent       number(5)      ,/* 企業編號 */
nmakstus       varchar2(10)      ,/* 狀態碼 */
nmak001       varchar2(10)      ,/* 現金異動碼分類編碼 */
nmak002       varchar2(1)      ,/* 大類 */
nmak003       varchar2(1)      ,/* 流入/流出 */
nmakownid       varchar2(20)      ,/* 資料所有者 */
nmakowndp       varchar2(10)      ,/* 資料所屬部門 */
nmakcrtid       varchar2(20)      ,/* 資料建立者 */
nmakcrtdp       varchar2(10)      ,/* 資料建立部門 */
nmakcrtdt       timestamp(0)      ,/* 資料創建日 */
nmakmodid       varchar2(20)      ,/* 資料修改者 */
nmakmoddt       timestamp(0)      ,/* 最近修改日 */
nmakud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmakud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmakud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmakud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmakud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmakud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmakud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmakud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmakud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmakud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmakud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmakud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmakud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmakud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmakud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmakud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmakud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmakud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmakud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmakud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmakud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmakud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmakud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmakud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmakud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmakud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmakud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmakud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmakud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmakud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
nmak004       varchar2(1)      /* 加減項 */
);
alter table nmak_t add constraint nmak_pk primary key (nmakent,nmak001) enable validate;

create unique index nmak_pk on nmak_t (nmakent,nmak001);

grant select on nmak_t to tiptop;
grant update on nmak_t to tiptop;
grant delete on nmak_t to tiptop;
grant insert on nmak_t to tiptop;

exit;
