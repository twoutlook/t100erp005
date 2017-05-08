/* 
================================================================================
檔案代號:icaa_t
檔案名稱:多角貿易流程代碼檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table icaa_t
(
icaaent       number(5)      ,/* 企業編號 */
icaasite       varchar2(10)      ,/* 營運據點 */
icaa001       varchar2(10)      ,/* 流程代碼 */
icaa003       varchar2(10)      ,/* 流程類型 */
icaa004       varchar2(10)      ,/* 出貨/收貨確立點 */
icaa005       varchar2(1)      ,/* 收貨時中斷否 */
icaa006       varchar2(10)      ,/* 最終供應商取價方式 */
icaa007       varchar2(1)      ,/* 流水號保持一致否 */
icaa008       varchar2(10)      ,/* 流程序號編碼方式 */
icaa009       varchar2(1)      ,/* 無轉撥單價是否允許拋轉否 */
icaa010       varchar2(10)      ,/* 轉撥單價取價方式 */
icaaownid       varchar2(20)      ,/* 資料所有者 */
icaaowndp       varchar2(10)      ,/* 資料所屬部門 */
icaacrtid       varchar2(20)      ,/* 資料建立者 */
icaacrtdp       varchar2(10)      ,/* 資料建立部門 */
icaacrtdt       timestamp(0)      ,/* 資料創建日 */
icaamodid       varchar2(20)      ,/* 資料修改者 */
icaamoddt       timestamp(0)      ,/* 最近修改日 */
icaastus       varchar2(10)      ,/* 狀態碼 */
icaa011       varchar2(1)      ,/* 出通單開立點 */
icaa012       varchar2(10)      ,/* 多角應收付開立方式 */
icaa013       varchar2(10)      ,/* 內/外銷 */
icaaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
icaaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
icaaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
icaaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
icaaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
icaaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
icaaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
icaaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
icaaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
icaaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
icaaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
icaaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
icaaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
icaaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
icaaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
icaaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
icaaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
icaaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
icaaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
icaaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
icaaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
icaaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
icaaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
icaaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
icaaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
icaaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
icaaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
icaaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
icaaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
icaaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
icaa014       varchar2(10)      /* Invoice/Packing開立點 */
);
alter table icaa_t add constraint icaa_pk primary key (icaaent,icaa001) enable validate;

create unique index icaa_pk on icaa_t (icaaent,icaa001);

grant select on icaa_t to tiptop;
grant update on icaa_t to tiptop;
grant delete on icaa_t to tiptop;
grant insert on icaa_t to tiptop;

exit;
